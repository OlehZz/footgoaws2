output "vpc_id" {
  value = aws_vpc.vpc-main.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc-main.cidr_block
}

output "dev_public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

output "dev_private_subnet_ids" {
  value = aws_subnet.private-subnets[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_mysql_private_subnet.name
}