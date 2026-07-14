# Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "starttech_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "starttech-vpc"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.starttech_vpc.id

  tags = {
    Name        = "starttech-igw"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Public Subnet A
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.starttech_vpc.id

  cidr_block = "10.0.1.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  map_public_ip_on_launch = true

  tags = {
    Name                     = "starttech-public-subnet-a"
    Environment              = var.environment
    ManagedBy                = "Terraform"
    "kubernetes.io/role/elb" = "1"
  }
}

# Public Subnet B
resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.starttech_vpc.id

  cidr_block = "10.0.2.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  map_public_ip_on_launch = true

  tags = {
    Name                     = "starttech-public-subnet-b"
    Environment              = var.environment
    ManagedBy                = "Terraform"
    "kubernetes.io/role/elb" = "1"
  }
}

# Private Subnet A
resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.starttech_vpc.id

  cidr_block = "10.0.11.0/24"

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name                              = "starttech-private-subnet-a"
    Environment                       = var.environment
    ManagedBy                         = "Terraform"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Private Subnet B
resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.starttech_vpc.id

  cidr_block = "10.0.12.0/24"

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                              = "starttech-private-subnet-b"
    Environment                       = var.environment
    ManagedBy                         = "Terraform"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "starttech-nat-eip"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public_a.id

  tags = {
    Name        = "starttech-nat-gateway"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_internet_gateway.main
  ]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.starttech_vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "starttech-public-rt"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.starttech_vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "starttech-private-rt"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Public subnets association
resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id

  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id = aws_subnet.public_b.id

  route_table_id = aws_route_table.public.id
}

# Private subnets association
resource "aws_route_table_association" "private_a" {
  subnet_id = aws_subnet.private_a.id

  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id = aws_subnet.private_b.id

  route_table_id = aws_route_table.private.id
}