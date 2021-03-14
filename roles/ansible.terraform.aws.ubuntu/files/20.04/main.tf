variable "access_key" {
  type = string
  sensitive = true
}
variable "secret_key" {
  type = string
  sensitive = true
}
variable "ssh_public_key" {
  type = string
  sensitive = true
}
variable "vm_version" {
  type = string
  sensitive = false
}

provider "aws" {
  region = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "random_string" "random" {
  length = 16
  special = false

}
resource "aws_key_pair" "deployer" {
  key_name   = "labo-key-pair-${random_string.random.result}"
  public_key = var.ssh_public_key
}


resource "aws_security_group" "labo" {
  name = "generate-security-terraform-key-${random_string.random.result}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "labo" {
  ami           = "ami-0aef57767f5404a3c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.labo.id]
//  vpc_security_group_ids = ["sg-0095033037ad91574"]
  tags = {
    Name = "Labo-ubuntu-${var.vm_version}-${random_string.random.result}"
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
