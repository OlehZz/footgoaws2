data "aws_availability_zones" "az" {}

# create ASG policy
resource "aws_autoscaling_policy" "web" {
  name        = "footgo_AS_policy"
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
  launch_configuration = var.aws_launch_configuration
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  #min_elb_capacity = 1
  health_check_type   = "EC2"
  load_balancers      = [aws_elb.webserver.name]
  vpc_zone_identifier = [var.public_subnet_id]
  force_delete        = true
  tags = [
    {
      key                 = "Name"
      value               = "WebServer in ASG"
      propagate_at_launch = true
    },
  ]
}

#Create ELB
resource "aws_elb" "webserver" {
  name            = "webserver-ELB"
  security_groups = [var.webserver_sg]
  subnets         = [var.public_subnet_id]
  listener {
    lb_port           = 8080
    lb_protocol       = "http"
    instance_port     = 8080
    instance_protocol = "http"
  }
  /*health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:8080/"
        interval            = 10
   }*/
  tags = {
    Name = "WebServer-ELB"
  }
}