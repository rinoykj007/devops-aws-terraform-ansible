provider "aws" {
  region = "eu-north-1"
}

# Import existing key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-new"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCQJKVvujwjW6BkikXtQvuVDylq+1YooavI3bTdb4XlsTvOq4K2qwQ4APOyuqj5tgdApdL6vWqfvgbzgJmEPGfFBb+qcKPmAD3l4JY+Io27Rp0V8YT340+2B30r2B5gXst62/yWhPmc2G+eYZTIoI/+FlaYS8YcK806Bd2qHF1/xXGRAKlDA7+8+RocTNsx1V774dFypOPwxx5TWohlNkPJkfFZ3UNheduH4u7TR6xMZAW+qIFfI/iB2ixPim6+NX6Do7eo041WaEkGvO4JiUbSOL2JCX3ZnOxunU7wJ+FSwHcHeBboNeby9ffrR8MjHcM18Wp2VN0WZSYlb3etAL2z root@RKJ"

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      public_key
    ]
  }
}

# Use existing security group
data "aws_security_group" "existing_web_server" {
  name = "web_server"
}

resource "aws_instance" "web_server" {
  ami           = "ami-02e2af61198e99faf"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [data.aws_security_group.existing_web_server.id]

  tags = {
    Name = "DevOps_Ca1"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
