variable "nsg-pub-ec2" {
  description = "Security Group Id"
  type        = string
}

variable "nsg-prv-ec2" {
  description = "Security Group Id"
  type        = string
}


variable "mypublicsubnet_1a" {
  description = "first public subnet"
  type        = string
}

variable "mypublicsubnet_1b" {
  description = "second public subnet"
  type        = string
}

variable "myprivatesubnet_1a" {
  description = "first private subnet"
  type        = string
}

variable "myprivatesubnet_1b" {
  description = "first private subnet"
  type        = string
}
