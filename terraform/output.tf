output "instance_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.web.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of EC2 instance"
  value       = aws_instance.web.public_dns
}