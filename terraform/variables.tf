variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "app_port" {
  description = "Port your Node.js app runs on"
  type        = number
  default     = 3000
}

variable "allowed_ssh_cidr" {
  description = "Intentionally insecure SSH CIDR for first scan"
  type        = string
  default     = "0.0.0.0/0"
}