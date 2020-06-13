resource "aws_security_group" "security_group_eks_cluster" {
  name        = "terraform-eks-cluster"
  description = "cluster communication with worker nodes"
  vpc_id      = aws_vpc.vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-sg"
  }
}

