
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    name = var.vpc_config.name
  }
}

resource "aws_subnet" "my-subnet" {
  vpc_id   = aws_vpc.my_vpc.id
  for_each = var.subnet_config

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    name = each.key
  }
}

locals {
  pub_sunet = {
    for key, config in var.subnet_config : key => config if config.public
  }

  private_sunet = {
    for key, config in var.subnet_config : key => config if !config.public
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  count  = length(local.pub_sunet) > 0 ? 1 : 0
}

#Route table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id
  count  = length(local.pub_sunet) > 0 ? 1 : 0

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw[0].id
  }
}

## Route table association
resource "aws_route_table_association" "my_rt_association" {
  for_each = local.pub_sunet

  subnet_id      = aws_subnet.my-subnet[each.key].id
  route_table_id = aws_route_table.my_rt[0].id

}
