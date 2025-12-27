variable "project_id" {
  description = "ID do projeto no GCP"
  type        = string
}

variable "region" {
  default = "us-central1" # Região elegível para o nível gratuito
}

variable "zone" {
  default = "us-central1-a"
}

variable "allowed_ip" {
  description = "Seu IP público para acessar o banco (ex: 200.x.x.x/32)"
  type        = string
}

variable "db_password" {
  description = "Senha do usuário postgres"
  type        = string
  sensitive   = true
}