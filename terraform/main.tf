provider "aws" {
  region = "eu-west-1"
}

# Import existing security group
data "aws_security_group" "web_server" {
  id = "sg-0f108ebec9a19226a"
}

# Use existing EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0694d931cee176e7d"  # Amazon Linux 2 AMI in eu-west-1
  instance_type = "t3.micro"
  key_name      = "deployer-key-new"

  vpc_security_group_ids = [data.aws_security_group.web_server.id]

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
