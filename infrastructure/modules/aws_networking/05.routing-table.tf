#This create public & private routing tables
resource "aws_route_table" "mypubrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "mypubrt"
  }
}

resource "aws_route_table" "myprvrt" {
  vpc_id = aws_vpc.myvpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }

    tags = {
    Name = "myprvrt"
  }
}
