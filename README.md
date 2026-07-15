# StartTech Infrastructure

## Overview

This repository contains the Infrastructure as Code (IaC) used to provision the cloud resources required for the StartTech application.

Infrastructure is managed using Terraform and deployed to AWS.

---

# Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── terraform/
│   ├── modules/
│   │   ├── networking/
│   │   ├── eks/
│   │   ├── storage/
│   │   ├── database/
│   │   └── cdn/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── k8s/
├── scripts/
└── README.md
```

---

# AWS Services

Infrastructure provisions the following AWS resources:

* Amazon VPC
* Public and Private Subnets
* Internet Gateway
* Route Tables
* NAT Gateway
* Amazon EKS Cluster
* Amazon ECR
* Amazon S3
* Amazon CloudFront
* Amazon ElastiCache (Redis)
* IAM Roles and Policies
* Security Groups

MongoDB Atlas is used as the application's primary database and is managed outside AWS.

---

# Infrastructure Architecture

```text
Terraform

        │

        ▼

AWS

├── Networking
├── IAM
├── Amazon EKS
├── Amazon ECR
├── Amazon S3
├── CloudFront
├── ElastiCache
└── Security Groups
```

---

# Terraform Modules

The infrastructure is organised into reusable modules.

## networking

Creates:

* VPC
* Subnets
* Route Tables
* Internet Gateway
* NAT Gateway

---

## eks

Creates:

* Amazon EKS Cluster
* Managed Node Group
* IAM Roles

---

## storage

Creates:

* Amazon S3 bucket

---

## database

Creates:

* Amazon ElastiCache Redis

MongoDB Atlas is configured separately.

---

## cdn

Creates:

* CloudFront Distribution
* Origin Access Control

---

# Deployment

Initialize Terraform

```bash
terraform init
```

Validate configuration

```bash
terraform validate
```

Generate execution plan

```bash
terraform plan
```

Apply infrastructure

```bash
terraform apply
```

---

# Deployment Script

Infrastructure can also be deployed using:

```bash
./scripts/deploy-infrastructure.sh
```

---

# GitHub Actions

Infrastructure deployment is automated using GitHub Actions.

The workflow performs:

* Terraform Format
* Terraform Init
* Terraform Validate
* Terraform Plan
* Terraform Apply

---

# Prerequisites

* AWS Account
* Terraform
* AWS CLI
* kubectl
* Docker

---

# Outputs

Terraform outputs include resources such as:

* EKS Cluster Name
* VPC ID
* CloudFront Distribution
* S3 Bucket
* Redis Endpoint

---

# Security

Sensitive values are not committed to source control.

Configuration requiring secrets is managed through:

* GitHub Actions Secrets
* Kubernetes Secrets
* AWS IAM

---

# Cleanup

To destroy all provisioned resources

```bash
terraform destroy
```

---

# Author

Ayotunde
