# Cluster Security Group
resource "aws_security_group" "cluster" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "Security group for the EKS control plane"

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.cluster_name}-cluster-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Worker Node Security Group
# Kubernetes nodes constantly communicate.
resource "aws_security_group" "nodes" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS worker nodes"

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.cluster_name}-node-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Allow Nodes to Talk to Each Other
resource "aws_security_group_rule" "nodes_internal" {
  type = "ingress"

  from_port = 0
  to_port   = 65535
  protocol  = "-1"

  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.nodes.id
}

# Allow Cluster → Nodes
# The control plane needs to reach the kubelet running on every worker node.
resource "aws_security_group_rule" "cluster_to_nodes" {
  type = "ingress"

  from_port = 1025
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.cluster.id
}

# Allow Nodes → Cluster
# Worker nodes need to reach the Kubernetes API over HTTPS.
resource "aws_security_group_rule" "nodes_to_cluster" {
  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.nodes.id
}

# Outbound Rules
# AWS now recommends managing egress rules separately rather than relying on the default "allow all" rule.
# Cluster
resource "aws_vpc_security_group_egress_rule" "cluster_all" {
  security_group_id = aws_security_group.cluster.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}

# Node
resource "aws_vpc_security_group_egress_rule" "nodes_all" {
  security_group_id = aws_security_group.nodes.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}

# SSH SG
resource "aws_security_group" "ssh" {
  name        = "${var.cluster_name}-ssh-sg"
  description = "Allow SSH to EKS worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.cluster_name}-ssh-sg"
    }
  )
}

# A rule that accepts SSH from the SSH security group.
resource "aws_security_group_rule" "ssh_to_nodes" {
  type = "ingress"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.ssh.id

  description = "Allow SSH from SSH security group to worker nodes"
}