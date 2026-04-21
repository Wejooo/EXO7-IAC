variable "aws_region" {
  description = "Region AWS (le Learner Lab est restreint a us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI Amazon Linux 2023 (x86_64) pour us-east-1"
  type        = string
  default     = "ami-007e7b4c0d6279cd4"
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.small"
}

variable "instance_name" {
  description = "Nom (tag Name) de l'instance EC2"
  type        = string
  default     = "tp7-semaphore"
}

variable "app_port" {
  description = "Port expose par SemaphoreUI"
  type        = number
  default     = 3000
}

variable "key_name" {
  description = "Key pair du Learner Lab (toujours 'vockey')"
  type        = string
  default     = "vockey"
}

variable "pem_path" {
  description = "Chemin local du vockey.pem telecharge depuis AWS Academy"
  type        = string
  default     = "./vockey.pem"
}

variable "admin_user" {
  description = "Login admin SemaphoreUI"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Mot de passe admin SemaphoreUI"
  type        = string
  default     = "changeme"
}

variable "admin_email" {
  description = "Email admin SemaphoreUI"
  type        = string
  default     = "admin@localhost"
}
