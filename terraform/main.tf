provider "aws" {
  region = "eu-west-1"
}

# Use existing security group
resource "aws_security_group" "web_server" {
  name        = "web_server"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_server"
  }

  # Prevent recreation of existing security group
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      description,
      tags
    ]
  }
}

# Use existing EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0694d931cee176e7d"  # Amazon Linux 2 AMI in eu-west-1
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web_server.id]

  tags = {
    Name = "DevOps_Ca1"
  }

  # Prevent recreation of existing instance
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      ami,
      key_name,
      tags
    ]
  }
}

# Output the public IP
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
