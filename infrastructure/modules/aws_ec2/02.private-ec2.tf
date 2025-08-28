resource "aws_instance" "private-ec2a" {
  ami                    = "ami-00ca32bbc84273381"
  instance_type          = "t3.micro"
  key_name               = "tf-key"
  vpc_security_group_ids = [var.nsg-prv-ec2]
  subnet_id              = var.myprivatesubnet_1a
  user_data = <<-EOF
              #!/bin/bash
              for i in {1..5}; do
              sudo yum install httpd -y && sudo break
              sleep 60
              done
              sudo yum install httpd -y
              sudo echo "This is prod web server" > /var/www/html/index.html
              sudo systemctl enable --now httpd
              EOF
  tags = {
    Name = "private-ec2a"
  }
}#


resource "aws_instance" "private-ec2b" {
  ami                    = "ami-00ca32bbc84273381"
  instance_type          = "t3.micro"
  key_name               = "tf-key"
  vpc_security_group_ids = [var.nsg-prv-ec2]
  subnet_id              = var.myprivatesubnet_1b
  user_data = <<-EOF
              #!/bin/bash
              for i in {1..5}; do
              sudo yum install httpd -y && sudo break
              sleep 60
              done
              sudo mkdir /var/www/html/staging
              sudo echo "This is staging test web server" > /var/www/html/staging/index.html
              sudo systemctl enable --now httpd
              EOF
  tags = {
    Name = "private-ec2b"
  }
}#
