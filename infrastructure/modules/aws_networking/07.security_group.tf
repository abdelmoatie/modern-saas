#This creates custom security group
resource "aws_security_group" "nsg-pub-ec2" {
  name        = "nsg-pub-ec2"
  description = "Allow custom inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id
  tags = {
    Name = "nsg-pub-ec2"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_1" {
  security_group_id = aws_security_group.nsg-pub-ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4_1" {
  security_group_id = aws_security_group.nsg-pub-ec2.id
  cidr_ipv4         = "18.206.107.24/29" #The EC2 Instance Connect service IP range in us-east-1 
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_1" {
  security_group_id = aws_security_group.nsg-pub-ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_security_group" "nsg-prv-ec2" {
  name        = "nsg-prv-ec2"
  description = "Allow custom inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id
  tags = {
    Name = "nsg-prv-ec2"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_2" {
  security_group_id = aws_security_group.nsg-prv-ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4_2" {
  security_group_id = aws_security_group.nsg-prv-ec2.id
  cidr_ipv4         = "10.0.1.0/24" #Allow SSH from the public subnet
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_2" {
  security_group_id = aws_security_group.nsg-prv-ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
