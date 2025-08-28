output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "mypublicsubnet_1a" {
  value = aws_subnet.mypublicsubnet_1a.id
}

output "mypublicsubnet_1b" {
  value = aws_subnet.mypublicsubnet_1b.id
}


output "myprivatesubnet_1a" {
  value = aws_subnet.myprivatesubnet_1a.id
}

output "myprivatesubnet_1b" {
  value = aws_subnet.myprivatesubnet_1b.id
}

output "nsg-pub-ec2" {
  value = aws_security_group.nsg-pub-ec2.id
}

output "nsg-prv-ec2" {
  value = aws_security_group.nsg-prv-ec2.id
}
