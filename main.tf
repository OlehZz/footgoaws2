/*resource "aws_instance" "example" {
        ami           = "ami-0ac80df6eff0e70b5"
        instance_type = "t2.micro"
        key_name      = "MyEC2 study1"

    provisioner "file" {
        source      = "script.sh"
        destination = "/tmp/script.sh"
    }
    provisioner "remote-exec" {
        inline = [
          "chmod +x /tmp/script.sh",
          "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
          "sudo /tmp/script.sh",
        ]
    }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}*/

data "aws_availability_zones" "az" {}

module "vpc-main" {
  source     = "./modules/network"
}

module "security-group" {
  source = "./modules/security_group"
  vpc_id = module.vpc-main.vpc_id
}

module "asg_elb" {
    source = "./modules/asg_elb"
    public_subnet_id = module.vpc-main.dev_public_subnet_id
    #private_subnet_ids = module.vpc-main.dev_private_subnet_ids
    webserver_sg = module.security-group.webserver_sg
    aws_launch_configuration = module.instances.aws_launch_configuration_name
    
}

module "instances" {
    source = "./modules/instances"
    webserver_sg = module.security-group.webserver_sg
}

module "rds" {
    source = "./modules/rds"
    db_subnet_group_name = module.vpc-main.db_subnet_group_name
    mysql_sg = module.security-group.mysql_sg
}