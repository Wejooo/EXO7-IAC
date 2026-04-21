resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-USERDATA
    #!/bin/bash
    set -eux

    # 1) Installation Docker
    dnf update -y
    dnf install -y docker
    systemctl enable --now docker
    usermod -aG docker ec2-user

    # 2) Reseau Docker interne
    docker network create semaphore-net

    # 3) Volume persistant pour Postgres
    mkdir -p /var/lib/semaphore/postgres

    # 4) Postgres 14
    docker run -d \
      --name postgres \
      --network semaphore-net \
      --restart unless-stopped \
      -e POSTGRES_USER=semaphore \
      -e POSTGRES_PASSWORD=semaphore \
      -e POSTGRES_DB=semaphore \
      -v /var/lib/semaphore/postgres:/var/lib/postgresql/data \
      postgres:14

    sleep 20

    # 5) Cle de chiffrement SemaphoreUI
    ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

    # 6) SemaphoreUI
    docker run -d \
      --name semaphore \
      --network semaphore-net \
      --restart unless-stopped \
      -p ${var.app_port}:3000 \
      -e SEMAPHORE_DB_DIALECT=postgres \
      -e SEMAPHORE_DB_HOST=postgres \
      -e SEMAPHORE_DB_PORT=5432 \
      -e SEMAPHORE_DB_USER=semaphore \
      -e SEMAPHORE_DB_PASS=semaphore \
      -e SEMAPHORE_DB=semaphore \
      -e SEMAPHORE_PLAYBOOK_PATH=/tmp/semaphore/ \
      -e SEMAPHORE_ADMIN=${var.admin_user} \
      -e SEMAPHORE_ADMIN_PASSWORD=${var.admin_password} \
      -e SEMAPHORE_ADMIN_NAME=${var.admin_user} \
      -e SEMAPHORE_ADMIN_EMAIL=${var.admin_email} \
      -e SEMAPHORE_ACCESS_KEY_ENCRYPTION=$ENCRYPTION_KEY \
      semaphoreui/semaphore:latest
  USERDATA

  tags = {
    Name = var.instance_name
    Role = "app"
  }
}
