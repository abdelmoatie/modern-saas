resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  tags = {
    Name = "nat_gateway_eip"
  }
}

resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.mypublicsubnet_1a.id  # NAT must be in a public subnet

  tags = {
    Name = "nat-gateway"
  }

  depends_on = [aws_internet_gateway.myigw] # Ensure IGW is created first
}
