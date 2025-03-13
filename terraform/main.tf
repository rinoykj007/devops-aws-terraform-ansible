provider "aws" {
  region = "eu-north-1"
}

# Use existing key pair
data "aws_key_pair" "existing" {
  key_name = "deployer-key-new"
}

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

# Create security group
resource "aws_security_group" "web_server" {
  name        = "web_server"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

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
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-02e2af61198e99faf"  # Amazon Linux 2 AMI in eu-north-1
  instance_type = "t3.micro"
  key_name      = data.aws_key_pair.existing.key_name

  vpc_security_group_ids = [aws_security_group.web_server.id]

  tags = {
    Name = "DevOps_Ca1"
  }
}

# Output the public IP
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
