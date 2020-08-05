#ec2 for ASG
resource "aws_launch_configuration" "web" {
    name            = "Webserver"
    key_name = "MyEC2 study1"
    image_id        = "ami-0ac80df6eff0e70b5"
    instance_type   = "t2.micro"
    security_groups = [aws_security_group.webserver.id]
}
# create ASG policy
resource "aws_autoscaling_policy" "web" {
    name                = "footgo_AS_policy"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
    target_value = 20.0
  }
    autoscaling_group_name = aws_autoscaling_group.webservers.name
}  
# Create ASG
resource "aws_autoscaling_group" "webservers" {
    name                 = "ASG webservers"
    launch_configuration = aws_launch_configuration.web.name
    min_size             = 1
    max_size             = 2
    desired_capacity     = 1
    health_check_type    = "EC2"
    vpc_zone_identifier  = [var.public_subnet_id]
    force_delete              = true
}

#db subnet group
resource "aws_db_subnet_group" "rds_mysql_private_subnet" {
  name       = "rds_mysql_private_subnet"
  subnet_ids = [var.subnet_ids]

  tags = {
    Name = "My DB subnet group"
  }
}

#create db
resource "aws_db_instance" "mysql_db" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t2.micro"
    db_subnet_group_name = aws_db_subnet_group.rds_mysql_private_subnet.name
    name                 = "footgo"
    vpc_security_group_ids = [aws_security_group.mysql_rds_sg.id]
    username             = "footgo"
    password             = "footgodb"
}