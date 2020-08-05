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

module "vpc-main" {
  source     = "./modules/network"
}

module "security-group" {
  source = "./modules/security_group"
  vpc_id = "${module.vpc-main.vpc_id}"
}