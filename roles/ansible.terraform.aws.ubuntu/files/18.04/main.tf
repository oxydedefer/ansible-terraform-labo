variable "access_key" {}
variable "secret_key" {}
variable "ssh_public_key" {}
variable "vm_version" {}

provider "aws" {
  region = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

//resource "aws_key_pair" "deployer" {
//  key_name   = "deployer-key"
//  public_key = var.ssh_public_key
//}

//resource "aws_security_group" "labo" {
//  name = "generate-security-terraform"
//
//  ingress {
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//    from_port   = 80
//    to_port     = 80
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//    from_port   = 8080
//    to_port     = 8080
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//    from_port   = 9100
//    to_port     = 9100
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//   egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}

resource "aws_instance" "labo" {
  ami           = "ami-0dc8d444ee2a42d8a"
  instance_type = "t2.micro"
  key_name      = "deployer-key"
//  vpc_security_group_ids = [aws_security_group.labo.id]
  vpc_security_group_ids = ["sg-0095033037ad91574"]
  tags = {
    Name = "Labo-ubuntu-${var.vm_version} "
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
