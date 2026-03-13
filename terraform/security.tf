resource "aws_security_group" "web_sg" {
  name        = "devops-assignment-sg"
  description = "Allow SSH and app access"
  vpc_id      = aws_vpc.main.id

   
   # Vulnerability: Allowing SSH from anywhere
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]  
  }

  ingress {
    description = "App access"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    description = "HTTP outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-assignment-web-sg"
  }
}