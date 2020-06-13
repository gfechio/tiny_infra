resource "aws_security_group" "eks-cluster" {
  name        = "terraform-eks-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.default.id

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

resource "aws_security_group" "backbase-centos7" {
  name        = "backbase-centos7"
  description = "Outbound access"
  vpc_id      = aws_vpc.default.id

  // outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backbase-centos-security-group-outbound"
  }
}

resource "aws_security_group_rule" "centos-ingress-ssh" {
  description       = "Allow ssh access"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.backbase-centos7.id
  to_port           = 22
  type              = "ingress"

}

