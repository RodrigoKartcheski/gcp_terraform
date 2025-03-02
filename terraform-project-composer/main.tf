# Arquivo principal do Terraform onde  definimos recursos, providers, etc.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google-beta" {
  project = var.PROJECT
  region  = var.REGION
}
