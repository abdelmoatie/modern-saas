#This creates Private & Public subnets and attaches it to our VPC
resource "aws_subnet" "mypublicsubnet_1a" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "mypublicsubnet_1a"
  }
}

resource "aws_subnet" "mypublicsubnet_1b" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "mypublicsubnet_1b"
  }
}

resource "aws_subnet" "myprivatesubnet_1a" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "myprivatesubnet_1a"
  }
}

resource "aws_subnet" "myprivatesubnet_1b" {
  cidr_block              = "10.0.4.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "myprivatesubnet_1b"
  }
}
