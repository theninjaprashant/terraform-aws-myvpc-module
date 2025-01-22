output "vpc_id_is" {
  value = aws_vpc.my_vpc.id
}

locals {
  pub_subnet_output = {
    for key, config in local.pub_sunet : key =>{
        subnet_id_is = aws_subnet.my-subnet[key].id
        az_is = aws_subnet.my-subnet[key].availability_zone
    }
  }

   private_subnet_output = {
    for key, config in local.private_sunet : key =>{
        subnet_id_is = aws_subnet.my-subnet[key].id
        az_is = aws_subnet.my-subnet[key].availability_zone
    }
  }
}


output "public_subnet_ids" {
  value = local.pub_subnet_output
}

output "private_subnet_ids" {
  value = local.private_subnet_output
}

