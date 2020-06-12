resource "aws_instance" "myec2" {
    ami = "ami-0a02ee601d742e89f"
    instance_type = "t2.micro"
}

resource "aws_vpc" "backbase_vpc" {
  cidr_block = "10.0.0.0/16"
}
