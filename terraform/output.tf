output "instance_elastic_ip" {
  description = "Elastic (static) public IP of EC2 instance"
  value       = aws_eip.web_eip.public_ip
}

output "instance_public_ip" {
  description = "Auto-assigned public IP of EC2 instance (may change, do not use if using EIP)"
  value       = aws_instance.web.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of EC2 instance"
  value       = aws_instance.web.public_dns
}