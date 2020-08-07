resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = var.db_subnet_group_name
  name                   = "footgo"
  vpc_security_group_ids = [var.mysql_sg]
  username               = "footgo"
  password               = "footgodb"
}