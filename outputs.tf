output "instance_public_ip" {
  description = "IP publique de l'instance EC2"
  value       = aws_instance.app.public_ip
}

output "semaphore_url" {
  description = "URL d'acces a SemaphoreUI"
  value       = "http://${aws_instance.app.public_ip}:${var.app_port}"
}

output "admin_credentials" {
  description = "Identifiants admin SemaphoreUI"
  value       = "${var.admin_user} / ${var.admin_password}"
}

output "ssh_command" {
  description = "Commande SSH prete a copier"
  value       = "ssh -i ${var.pem_path} ec2-user@${aws_instance.app.public_ip}"
}
