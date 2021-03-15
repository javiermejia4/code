## Outputs
output "checklist" {
  value = [for i in var.ingress_ports : "Port ${i} expected to be open"]
}

output "expected" {
  value = aws_security_group.allowed_traffic[*].ingress
}