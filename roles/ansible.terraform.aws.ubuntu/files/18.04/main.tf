variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


resource "aws_instance" "labo" {
  ami           = "ami-0dc8d444ee2a42d8a"
  instance_type = "t2.micro"
  key_name      = "ssh-seb-labo"
  vpc_security_group_ids = ["sg-0c3c40c6b66eda713"]
  tags = {
    Name = "Labo"
  }
}

output "public_ip_labo" {
  value       = aws_instance.labo.public_ip
  description = "The public IP of the web server"
}

output "name_labo" {
  value       = aws_instance.labo.tags.Name
  description = "The Name of the web server"
}

output "state_labo" {
  value       = aws_instance.labo.instance_state
  description = "The state of the web server"
}
