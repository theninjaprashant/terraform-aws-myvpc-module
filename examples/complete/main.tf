provider "aws" {
  region = "ap-south-1"
}
## This module project will create a vpc and subnets and if subnets are public
# then it will create a igw, rt, and associate rt with public subnets
module "my_module_vpc" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "my-test-vpc"
  }

  subnet_config = {
    public_subnet ={
      cidr_block = "10.0.1.0/24"
      az = "ap-south-1a"
      public = true
    }

    private_subnet = {
      cidr_block = "10.0.2.0/24"
      az = "ap-south-1b"
    }
  }
}