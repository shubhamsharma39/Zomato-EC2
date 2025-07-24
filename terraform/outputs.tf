output "region" {
  description = "The AWS region where resources are created"
  value       = local.region
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.testinstance.public_ip
}

