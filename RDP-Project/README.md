# Azure RDS (Remote Desktop Services) Project

This project deploys a production-ready Azure Virtual Desktop / RDS-style environment using Terraform and GitHub Actions CI/CD.

## Components
- Azure Virtual Network
- Subnets
- Network Security Groups
- Azure Bastion
- Azure Key Vault
- Log Analytics Workspace
- Session Host VMs
- Azure Compute Gallery support
- CI/CD Pipeline using GitHub Actions

## Folder Structure
```text
RDP-Project/
├── modules/
│   ├── networking/
│   ├── compute/
│   ├── monitoring/
│   └── security/
├── environments/
│   ├── dev/
│   └── prod/
├── .github/workflows/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
└── backend.tf
```

## Deployment
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## GitHub Actions Secrets
- ARM_CLIENT_ID
- ARM_CLIENT_SECRET
- ARM_SUBSCRIPTION_ID
- ARM_TENANT_ID
