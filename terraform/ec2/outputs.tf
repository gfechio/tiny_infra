output "public_ip" {
  description = "Public IP to ssh."
  value       = aws_instance.backbase_centos.public_ip
}

