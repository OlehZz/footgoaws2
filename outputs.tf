
output "vpc_id" {
  value = module.vpc-main.vpc_id
}

output "vpc_cidr" {
  value = module.vpc-main.vpc_cidr
}

output "dev_elb_dns_name" {
  value = module.asg_elb.elb_dns_name
}

output "dev_private_subnet_ids" {
  value = module.vpc-main.dev_private_subnet_ids
}
