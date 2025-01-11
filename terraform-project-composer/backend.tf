terraform {
  backend "gcs" {
    bucket = "cs_projeto_us_east1_terraform"  # Substitua pelo nome do bucket
    prefix = "terraform/state"                      # Organiza os arquivos de estado dentro do bucket
  }
}