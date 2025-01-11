# Arquivo onde as variáveis são declaradas.

variable "PROJECT" {
  description = "O projeto onde os recursos serão criados"
  type        = string
  default     = "my-project" # Valor padrão se não for especificado
}

variable "REGION" {
  description = "A região onde os recursos serão criados"
  type        = string
  default     = "us-east1" # Valor padrão se não for especificado
}

variable "ZONE" {
  description = "A zona específica para os recursos"
  type        = string
  default     = "us-east1-a"
}

variable "COMPOSER_NAME" {
  description = "O nome do ambiente do composer"
  type        = string
  default     = "cc-my-project-dev" # 
}

// em desuso
variable "COMPOSER_SA_ID" {
  description = "Nome do service account do Composer"
  type        = string
  default     = "44823525"
}

variable "BUCKET_OBJECT_DAGS_PREFIX" {
  description = "Nome do bucket para o Cloud Composer (DAGs e consultas)"
  type        = string
  default     = "cs_"
}

# Programador (Scheduler)
variable "SCHEDULER_CPU" {
  description = "Número de vCPUs para o programador"
  type        = number
  default     = 0.5
}

variable "SCHEDULER_MEMORY" {
  description = "Quantidade de memória (em GB) para o programador"
  type        = number
  default     = 2
}

variable "SCHEDULER_STORAGE" {
  description = "Espaço de armazenamento (em GB) para o programador"
  type        = number
  default     = 1
}

variable "SCHEDULER_COUNT" {
  description = "Número de instâncias do programador"
  type        = number
  default     = 1
}

# Acionador (Triggerer)
variable "TRIGGERER_CPU" {
  description = "Número de vCPUs para o acionador"
  type        = number
  default     = 0.5
}

variable "TRIGGERER_MEMORY" {
  description = "Quantidade de memória (em GB) para o acionador"
  type        = number
  default     = 1
}

variable "TRIGGERER_STORAGE" {
  description = "Espaço de armazenamento (em GB) para o acionador"
  type        = number
  default     = 1
}

variable "TRIGGERER_COUNT" {
  description = "Número de instâncias do acionador"
  type        = number
  default     = 1
}

# Servidor Web (Web Server)
variable "WEB_SERVER_CPU" {
  description = "Número de vCPUs para o servidor web"
  type        = number
  default     = 0.5
}

variable "WEB_SERVER_MEMORY" {
  description = "Quantidade de memória (em GB) para o servidor web"
  type        = number
  default     = 2
}

variable "WEB_SERVER_STORAGE" {
  description = "Espaço de armazenamento (em GB) para o servidor web"
  type        = number
  default     = 1
}

# Workers
variable "WORKER_CPU" {
  description = "Número de vCPUs para os workers"
  type        = number
  default     = 0.5
}

variable "WORKER_MEMORY" {
  description = "Quantidade de memória (em GB) para os workers"
  type        = number
  default     = 2
}

variable "WORKER_STORAGE" {
  description = "Espaço de armazenamento (em GB) para os workers"
  type        = number
  default     = 10
}

variable "WORKERS_MIN" {
  description = "Número mínimo de workers"
  type        = number
  default     = 1
}

variable "WORKERS_MAX" {
  description = "Número máximo de workers"
  type        = number
  default     = 3
}

variable "ENVIRONMENT_SIZE" {
  type    = string
  default = "ENVIRONMENT_SIZE_SMALL" # Escolha o valor apropriado
}