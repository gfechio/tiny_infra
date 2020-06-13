data "aws_ami" "backbase-centos7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["backbase-centos7"]
  }

  owners = ["self"]
}

resource "aws_instance" "backbase-centos7" {
  ami           = "centos7"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  ebs_optimized               = true
  disable_api_termination     = false
  monitoring                  = false
  tags = {
    Name = "backbase-centos7"
  }
}
