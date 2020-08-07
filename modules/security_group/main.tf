#create security group
resource "aws_security_group" "webserver" {
    name = "Webserver_public_SG"
    vpc_id = var.vpc_id

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Webserver-public-SG"
    }
}

#    description = "RDS security group
resource "aws_security_group" "mysql_rds_sg" {
    name = "mysql_rds_sg"
    vpc_id = var.vpc_id

    ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "mysql_rds_sg"
    }
}
