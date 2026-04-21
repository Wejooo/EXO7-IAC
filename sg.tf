resource "aws_security_group" "app_sg" {
  name        = "tp7-semaphore-sg"
  description = "SG pour SemaphoreUI (port app + SSH)"

  ingress {
    description = "SemaphoreUI HTTP"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tp7-semaphore-sg"
  }
}
