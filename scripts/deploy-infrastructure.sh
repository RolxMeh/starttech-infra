#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/../terraform"

echo "Formatting Terraform..."
terraform fmt -recursive

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform..."
terraform validate

echo "Planning Infrastructure..."
terraform plan

echo "Applying Infrastructure..."
terraform apply -auto-approve