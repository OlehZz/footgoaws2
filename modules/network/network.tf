data "aws_availability_zones" "az" {}
#vpc

resource "aws_vpc" "vpc-main" {
  cidr_block = var.vpc_cidr 
  tags = {
    Name = "${var.env}-vpc"
  }
}

#subnets

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.vpc-main.id
    cidr_block = var.public_subnet_cidrs
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "${var.env}-public"
    }
}
resource "aws_subnet" "private-subnets" {
    vpc_id = aws_vpc.vpc-main.id
    count = length(var.private_subnet_cidrs)
    cidr_block = element(var.private_subnet_cidrs, count.index)
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.az.names[count.index]
    tags = {
        Name = "${var.env}-private-${count.index + 1}"
    }
}

#db subnet group
resource "aws_db_subnet_group" "rds_mysql_private_subnet" {
    name       = "rds_mysql_private_subnets"
    subnet_ids = aws_subnet.private-subnets[*].id

    tags = {
    Name = "My DB subnet group"
  }
}

#Internet GW

resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.vpc-main.id
    tags = {
        Name = "${var.env}-internetGW"
    }
}

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.vpc-main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "${var.env}-route-public-subnet"
  }
}

resource "aws_route_table_association" "public_route" {
  route_table_id = aws_route_table.public_subnet.id
  subnet_id      = aws_subnet.public-subnet.id
}