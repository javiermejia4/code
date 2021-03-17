## Outputs
output "checklist" {
  value = [for i in var.ingress_ports : "Port ${i} expected to be open"]
}

output "expected" {
  value = aws_security_group.allowed_traffic[*].ingress
}

output "aws_public-subnet-1" {
  value = aws_subnet.public-subnet-1.id
}

output "aws_private-subnet-1" {
  value = aws_subnet.private-subnet-1.id
}