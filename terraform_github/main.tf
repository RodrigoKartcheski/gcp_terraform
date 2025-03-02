terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
<<<<<<< HEAD
  token = "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"
=======
  token = "xxxxxx"
>>>>>>> e4c3deb3af469d0444d19c177a26e3d4bc7f67e7
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
<<<<<<< HEAD
  
  depends_on = [
    github_repository.example
  ]
=======
>>>>>>> e4c3deb3af469d0444d19c177a26e3d4bc7f67e7
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
<<<<<<< HEAD
  
  depends_on = [
    github_repository.example
  ]
=======
>>>>>>> e4c3deb3af469d0444d19c177a26e3d4bc7f67e7
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
<<<<<<< HEAD
  default     = "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"
=======
  default     = "xxxx"
>>>>>>> e4c3deb3af469d0444d19c177a26e3d4bc7f67e7
  sensitive   = true
}

# https://registry.terraform.io/providers/hashicorp/github/3.0.0/docs/resources/repository_file
