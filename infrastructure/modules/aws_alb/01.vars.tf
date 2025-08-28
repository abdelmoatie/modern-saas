variable "my_vpc_id" {
  description = "My VPC Id"
  type        = string
}


variable "public_subnet_id01" {
  description = "ALP public subnet"
  type        = string
}

variable "public_subnet_id02" {
  description = "ALP public subnet"
  type        = string
}

variable "staging_ec2_id" {
  description = "staging test ec2 instance id"
  type        = string
}


variable "production_ec2_id" {
  description = "production ec2 instance id"
  type        = string
}
