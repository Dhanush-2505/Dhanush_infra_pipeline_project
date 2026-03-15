# Terraform Infrastructure Pipeline with Jenkins

## Project Overview

This project demonstrates a complete Infrastructure as Code (IaC) pipeline using **Terraform**, **Jenkins**, and **GitHub**.
The pipeline automatically provisions AWS infrastructure for different environments such as **dev** and **prod**.

The setup follows a typical DevOps workflow where infrastructure changes are managed through Git and automatically deployed using Jenkins pipelines.

---

# Architecture

GitHub Repository
↓
GitHub Webhook
↓
Jenkins Multibranch Pipeline
↓
Terraform Execution
↓
AWS Infrastructure

Infrastructure State Management:

Terraform → S3 Backend
State Locking → DynamoDB

---

# Technologies Used

* Terraform
* Jenkins
* GitHub
* AWS EC2
* AWS VPC
* AWS S3
* AWS DynamoDB
* Linux

---

# Repository Structure

```
iac_pipeline_project
│
├── modules
│   ├── vpc
│   │   └── main.tf
│   │
│   └── ec2
│       └── main.tf
│
├── environment
│   ├── dev
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── variables.tf
│   │
│   └── prod
│       ├── backend.tf
│       ├── main.tf
│       └── variables.tf
│
└── Jenkinsfile
```

---

# Terraform Backend

Terraform state is stored remotely using an **S3 bucket**.

State locking is handled using **DynamoDB** to prevent multiple users from modifying the state simultaneously.

Example backend configuration:

```
terraform {
  backend "s3" {
    bucket         = "infra-pipeline-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

---

# Jenkins Pipeline Stages

The Jenkins pipeline consists of the following stages:

### 1. Checkout

Fetches the latest Terraform code from GitHub.

### 2. Terraform Init

Initializes Terraform and configures the remote backend.

### 3. Terraform Plan

Generates an execution plan showing what infrastructure changes will occur.

### 4. Manual Approval

Requires manual approval before applying infrastructure changes.

### 5. Terraform Apply

Creates or updates infrastructure on AWS.

---

# Infrastructure Created

Terraform provisions the following resources:

* AWS VPC
* AWS Subnet
* EC2 Instances

Example configuration:

```
Instance Type : t3.micro
Environment   : dev / prod
Region        : ap-south-1
```

---

# CI/CD Workflow

1. Developer pushes code to GitHub.
2. GitHub webhook triggers Jenkins.
3. Jenkins Multibranch Pipeline detects the branch.
4. Terraform plan is generated.
5. Manual approval is requested.
6. Infrastructure is deployed to AWS.

---

# Environments

The project supports multiple environments.

### Development Environment

Used for testing infrastructure changes.

### Production Environment

Used for deploying production infrastructure.

Each environment has its own Terraform configuration.

---

# How to Run

Clone the repository:

```
git clone https://github.com/<username>/<repo>.git
```

Initialize Terraform:

```
terraform init
```

Generate plan:

```
terraform plan
```

Apply infrastructure:

```
terraform apply
```

---

# Future Improvements

Possible improvements for this project:

* Add Terraform validation stage
* Implement security scanning
* Add automated destroy stage
* Separate AWS accounts for environments
* Use Jenkins shared libraries

---

# Author

Dhanush

DevOps / Cloud Engineer
