provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Rede VPC e Subnet
resource "google_compute_network" "vpc_network" {
  name                    = "postgres-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "postgres-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# 2. Regra de Firewall (SSH e PostgreSQL)
resource "google_compute_firewall" "allow_postgres" {
  name    = "allow-postgres-and-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "5432"]
  }

  source_ranges = [var.allowed_ip] # Restrito ao seu IP por segurança
}

# 3. Instância VM (e2-micro - Always Free)
resource "google_compute_instance" "postgres_db" {
  name         = "postgres-free-tier"
  machine_type = "e2-micro" # 1GB RAM / 2 vCPUs
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 30 # Limite do nível gratuito
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnet.id
    access_config {
      # Isso gera um IP Público Efêmero (Grátis)
    }
  }

  # Script de inicialização para configurar o Banco e o SWAP
  metadata_startup_script = <<-EOT
    #!/bin/bash
    # 1. Configurar SWAP de 2GB
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab

    # 2. Instalar PostgreSQL
    apt-get update
    apt-get install -y postgresql postgresql-contrib

    # 3. Configurar PostgreSQL para aceitar conexões externas
    sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/ " /etc/postgresql/13/main/postgresql.conf
    echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/13/main/pg_hba.conf

    # 4. Otimizações de Memória para 1GB RAM
    sed -i "s/shared_buffers = .*/shared_buffers = 256MB/" /etc/postgresql/13/main/postgresql.conf
    sed -i "s/#effective_cache_size = .*/effective_cache_size = 768MB/" /etc/postgresql/13/main/postgresql.conf
    sed -i "s/#work_mem = .*/work_mem = 16MB/" /etc/postgresql/13/main/postgresql.conf

    # 5. Definir senha e reiniciar
    sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${var.db_password}';"
    systemctl restart postgresql
  EOT
}

output "public_ip" {
  value = google_compute_instance.postgres_db.network_interface[0].access_config[0].nat_ip
}