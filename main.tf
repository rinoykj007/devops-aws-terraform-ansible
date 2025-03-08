provider "aws" {
  region = "eu-north-1"
}

# Create a key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgkn45LLbtyD6g0/fEjrDoCOaTLaAwQwdq98aJn0MWvquIMzWN016D+ZkQH1N04jdG+wXg+Gu6lH6Q9QQX9fpzplnnLhiAjKFm5yayDJ5X7v8XhfVT8rD3q6nVXUtME8A0wtppQHq9ERjG51JeWmO2wqblqbgCiGSwnrKM/Ew+RS8qJuGewA940JnquRKrT/Ui2h/ak6d7/MpS2lOflOTRj+zX/A/iTVSps1ZHmTtGHfAbp+lfPfAF7rtatPRTAAc742uJk76HmV2KMknB/vD93FY9KXsQMyYIPaZf5SqyU1e+RZ0hyYn/53zjQJ+t5nuEhUJtAiqE0ofFmRBa5Rqr devops@example.com"
}

resource "aws_instance" "web_server" {
  ami           = "ami-02e2af61198e99faf"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.web_server.id]

  tags = {
    Name = "DevOps_Ca1"
  }
}

# Create a security group for web server
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
}

# Output the public IP
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
