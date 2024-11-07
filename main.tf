terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "eu-west-1"
  
}

resource "aws_instance" "web" {
  ami           = "ami-0d64bb532e0502c46"
  instance_type = "t2.micro"

  tags = {
    Name = "automation"
  }

  key_name = "aws"  # Make sure this key exists in your AWS account

  security_groups = ["web-sg"]
}

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"

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
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
