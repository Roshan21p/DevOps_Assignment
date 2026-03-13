resource "aws_security_group" "web_sg" {
  name        = "devops-assignment-sg"
  description = "Allow SSH and app access"
  vpc_id      = aws_vpc.main.id

   # SSH only from YOUR PUBLIC IP (fixes AWS-0107)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]  # e.g. 1.2.3.4/32
  }

  ingress {
    description = "App access"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  # Jenkins only from your public IP (NOT 0.0.0.0/0)
  ingress {
    description = "Jenkins access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  egress {
    description = "HTTP outbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-assignment-web-sg"
  }
}