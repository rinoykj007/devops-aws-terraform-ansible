#!/bin/bash

# Import existing security group
terraform import aws_security_group.web_server sg-0f108ebec9a19226a

# Import existing EC2 instance
terraform import aws_instance.web_server $(aws ec2 describe-instances --filters "Name=tag:Name,Values=DevOps_Ca1" --query "Reservations[0].Instances[0].InstanceId" --output text)
