provider "aws" {
  region = "eu-north-1"
}

# Use data sources to reference existing resources
data "aws_key_pair" "existing" {
  key_name = "deployer-key-new"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "existing" {
  name   = "web_server"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "web_server" {
  ami           = "ami-02e2af61198e99faf"
  instance_type = "t3.micro"
  key_name      = data.aws_key_pair.existing.key_name

  vpc_security_group_ids = [data.aws_security_group.existing.id]

  tags = {
    Name = "DevOps_Ca1"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
