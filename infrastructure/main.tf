terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}


module "aws_networking_mod" {
  source = "./modules/aws_networking"
}

module "aws_ec2_mod" {
  source = "./modules/aws_ec2"
  myprivatesubnet_1a = module.aws_networking_mod.myprivatesubnet_1a
  myprivatesubnet_1b = module.aws_networking_mod.myprivatesubnet_1b
  nsg-prv-ec2 = module.aws_networking_mod.nsg-prv-ec2
  nsg-pub-ec2 = module.aws_networking_mod.nsg-pub-ec2
  mypublicsubnet_1a = module.aws_networking_mod.mypublicsubnet_1a
  mypublicsubnet_1b = module.aws_networking_mod.mypublicsubnet_1b
}


module "aws_s3_mod" {
  source = "./modules/aws_s3"
}

module "aws_alb_mod" {
  source = "./modules/aws_alb"
  public_subnet_id01 = module.aws_networking_mod.mypublicsubnet_1a
  public_subnet_id02 = module.aws_networking_mod.mypublicsubnet_1b
  my_vpc_id = module.aws_networking_mod.vpc_id
  staging_ec2_id = module.aws_ec2_mod.private-ec2b
  production_ec2_id = module.aws_ec2_mod.private-ec2a
}
