terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.TOKEN  # Referencia a variável definida em terraform.tfvars
}

#################################
# passo 1 - criar o repositorio 
resource "github_repository" "dataform_pipeline" {
  name        = "dataform_terraform"
  description = "Minha incrível base de código"
  visibility  = "public"
}

resource "github_repository_file" "READEME" {
    repository = github_repository.dataform_pipeline.name  # Referenciando o nome do repositório
  file       = "README"
  content    = "**/*.tfstate"
}

#################################
# passo 2 - criar o arquivo .gitignore
resource "github_repository_file" "gitignore" {
  repository = github_repository.dataform_pipeline.name  # Referenciando o nome do repositório
  file       = ".gitignore"
  content    = "**/*.tfstate"

  depends_on = [
    github_repository.dataform_pipeline  # Garantindo a ordem de criação
  ]
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
  repository          = github_repository.dataform_pipeline.name  # Referenciando o nome do repositório
  branch              = "main"
  commit_message      = "[CI/CD] Adicionando arquivo ci-cd.yaml"
  overwrite_on_create = true
  file                = ".github/workflows/ci-cd.yaml"  # Caminho do arquivo no repositório GitHub
  content             = data.local_file.ci_cd_yaml.content
  
  depends_on = [
    github_repository.dataform_pipeline,  # Garantindo a ordem de criação
    github_repository_file.READEME
  ]
  
}

#################################
resource "github_branch" "development" {
  repository = github_repository.dataform_pipeline.name  # Referenciando o nome do repositório
  branch     = "development"

  depends_on = [
    github_repository.dataform_pipeline,  # Garantindo a ordem de criação
    github_repository_file.READEME
  ]
}

#################################
#variable "github_token" {
#  description = "Token de autenticação do GitHub"
#  type        = string

#  sensitive   = true
#}

# https://registry.terraform.io/providers/hashicorp/github/3.0.0/docs/resources/repository_file
