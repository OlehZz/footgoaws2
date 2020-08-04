output "vpc_id" {
  value = module.vpc-main.vpc_id
}

output "vpc_cidr" {
  value = module.vpc-main.vpc_cidr
}
/*
output "dev_public_subnet_id" {
  value = module.vpc-main.public-subnet_id
}

output "dev_private_subnet_ids" {
  value = module.vpc-main.private-subnets_ids
}*/