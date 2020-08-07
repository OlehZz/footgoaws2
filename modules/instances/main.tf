#ec2 for ASG
resource "aws_launch_configuration" "web" {
    name            = "Webserver"
    key_name = "MyEC2 study1"
    image_id        = "ami-0ac80df6eff0e70b5"
    instance_type   = "t2.micro"
    security_groups = [var.webserver_sg]
}