output "private-ec2a" {
  description = "The ID of the private ec2a instance"
  value       = aws_instance.private-ec2a.id
}

output "private-ec2b" {
  description = "The ID of the private ec2b instance"
  value       = aws_instance.private-ec2b.id
}
