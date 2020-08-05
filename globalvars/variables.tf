provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "footgo-project-devops"
        key = "globalvars/terraform.tfstate"
        region = "us-east-1"
}

 output "test" {
     value = test
 }