# Terraform Infrastructure Pipeline with Jenkins

## Project Overview

This project demonstrates an end-to-end **Infrastructure as Code (IaC) CI/CD pipeline** using **Terraform, Jenkins, GitHub, and AWS**.

Infrastructure changes are managed through Git, automatically triggered through GitHub webhooks, and deployed using a Jenkins pipeline.

The project also implements **remote Terraform state management using Amazon S3** and **state locking using DynamoDB**, which are recommended best practices for team-based Terraform workflows.

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

### Terraform Backend Architecture

Terraform
↓
Amazon S3 (Remote State Storage)
↓
DynamoDB (State Locking)

This setup prevents multiple users or pipelines from modifying the infrastructure state simultaneously.

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

Terraform state is stored remotely using an **Amazon S3 bucket** instead of being stored locally.

This enables multiple users or CI/CD pipelines to share the same infrastructure state safely.

To prevent concurrent infrastructure updates, **DynamoDB is used for Terraform state locking**.

### Backend Configuration Example

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

The Jenkins pipeline automates infrastructure deployment using the following stages:

### 1. Checkout

Fetches the latest Terraform code from the GitHub repository.

### 2. Terraform Init

Initializes Terraform and configures the remote backend.

### 3. Terraform Plan

Generates an execution plan that shows the infrastructure changes.

### 4. Manual Approval

Requires manual approval before infrastructure changes are applied.

### 5. Terraform Apply

Applies the Terraform plan and provisions infrastructure in AWS.

---

# Infrastructure Created

Terraform provisions the following AWS resources:

* VPC
* Subnet
* EC2 Instances

### Example Configuration

```
Instance Type : t3.micro
Environment   : dev / prod
Region        : ap-south-1
```

---

# CI/CD Workflow

1. Developer pushes infrastructure code to GitHub.
2. GitHub webhook triggers Jenkins automatically.
3. Jenkins Multibranch Pipeline detects the branch.
4. Terraform plan is generated.
5. Manual approval is required before deployment.
6. Terraform apply provisions infrastructure in AWS.

---

# Environments

The project supports multiple environments:

### Development Environment

Used for testing infrastructure changes.

### Production Environment

Used for deploying production infrastructure.

Each environment has its own Terraform configuration and backend state.

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

Generate execution plan:

```
terraform plan
```

Apply infrastructure:

```
terraform apply
```

---

# Future Improvements

Possible enhancements for this project:

* Add Terraform validation stage
* Implement security scanning using tools like tfsec
* Add automated destroy pipeline
* Separate AWS accounts for dev and prod
* Implement Jenkins shared libraries

---

# Author

Dhanush
DevOps / Cloud Engineer
dhanushnd2003@gmail.com
