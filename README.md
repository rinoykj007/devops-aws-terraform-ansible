# DevOps Project - Web Application Deployment

This project demonstrates a complete DevOps pipeline for deploying a web application using Terraform, Ansible, and Docker on AWS.

## Prerequisites

1. **AWS Account**
   - Active AWS account
   - AWS CLI installed and configured
   - AWS Access Key and Secret Key

2. **Required Tools**
   - Terraform (latest version)
   - Ansible (2.16.3 or later)
   - Docker (28.0.1 or later)
   - Git

3. **System Requirements**
   - Operating System: Windows with WSL (Ubuntu) or Linux
   - Python 3.x
   - SSH client

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd devops-project
```

### 2. AWS Configuration
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Region: eu-north-1
# Output format: json
```

### 3. Generate SSH Key
```bash
ssh-keygen -t rsa -b 4096 -C "devops@example.com" -f ~/.ssh/devops_key
```

### 4. Infrastructure Deployment (Terraform)
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### 5. Configure Ansible
Update `ansible/inventory.ini` with the new EC2 instance IP address (automatically updated by Terraform)

### 6. Run Ansible Playbook
```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

## Project Structure
```
devops-project/
├── app/
│   ├── index.html
│   └── Dockerfile
├── terraform/
│   └── main.tf
├── ansible/
│   ├── inventory.ini
│   └── playbook.yml
└── README.md
```

## Accessing the Application

Once deployed, the application will be available at:
```
http://<EC2-Instance-IP>
```

## Cleanup

To destroy the infrastructure when you're done:
```bash
cd terraform
terraform destroy -auto-approve
```

## Troubleshooting

1. **SSH Connection Issues**
   - Verify security group allows port 22
   - Check SSH key permissions (should be 600)
   - Ensure correct username in inventory.ini (ubuntu)

2. **Docker Issues**
   - Check Docker service status: `sudo systemctl status docker`
   - Verify user is in docker group: `groups`

3. **Web Access Issues**
   - Verify security group allows port 80
   - Check container status: `docker ps`
   - View container logs: `docker logs webapp`

## Team Members

1. **Infrastructure Lead**
   - AWS and Terraform management
   - Infrastructure provisioning

2. **Configuration Specialist**
   - Ansible configuration
   - Server management

3. **Containerization Expert**
   - Docker implementation
   - Container orchestration

4. **Security Engineer**
   - Security implementation
   - Access management

## Support

For any issues or questions, please contact any of the team members through the provided social links on the project website.
