output "instance_public_ip" {
  description = "Auto-assigned public IP of EC2 instance"
  value       = aws_instance.web.public_ip
}