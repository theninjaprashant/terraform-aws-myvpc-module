output "vpc_id_is" {
  value = module.my_module_vpc.vpc_id_is
}

output "public_subnets_are" {
  value = module.my_module_vpc.public_subnet_ids
}

output "private_subnets_are" {
  value = module.my_module_vpc.private_subnet_ids
}