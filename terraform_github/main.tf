terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = "xxxxx"
}

#################################
# passo 1 - criar o repositorio 
resource "github_repository" "example" {
  name        = "example"
  description = "Minha incrível base de código"
  visibility  = "public"
}

resource "github_branch" "development" {
  repository = "example"
  branch     = "development"
}

resource "github_repository_file" "READEME" {
  repository = "example"
  file       = "README"
  content    = "**/*.tfstate"
}

#################################
# passo 2 - criar o arquivo .gitignore
resource "github_repository_file" "gitignore" {
  repository = "example"
  file       = ".gitignore"
  content    = "**/*.tfstate"
}

#################################
# passo 3 - criar o arquivo de workflows

# Leitura do arquivo local ci-cd.yaml
data "local_file" "ci_cd_yaml" {
  filename = "${path.module}/ci-cd.yaml"  # Caminho para o arquivo ci-cd.yaml na sua máquina
}

#################################
# Subir o arquivo ci-cd.yaml para o repositório GitHub
resource "github_repository_file" "ci_cd_yaml" {
  repository          = github_repository.example.name
  branch              = "main"
  commit_message      = "[CI/CD] Adicionando arquivo ci-cd.yaml"
  overwrite_on_create = true
  file                = ".github/workflows/ci-cd.yaml"  # Caminho do arquivo no repositório GitHub
  content             = data.local_file.ci_cd_yaml.content
}

#################################
variable "github_token" {
  description = "Token de autenticação do GitHub"
  type        = string
  default     = "xxxx"
  sensitive   = true
}

# https://registry.terraform.io/providers/hashicorp/github/3.0.0/docs/resources/repository_file
