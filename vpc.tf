// VPC
resource "aws_vpc" "default" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags     = {
        Name = "DevOps-Challenge-VPC"
    }
}

// Public Subnet
resource "aws_subnet" "default" {
    vpc_id     = aws_vpc.default.id
    cidr_block = var.public_subnet_cidr

    tags = {
        Name = "DevOps-Challenge-Public-Subnet"
    }
}

// Route Tables
resource "aws_route_table" "default" {
    vpc_id = aws_vpc.default.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }

    tags = {
        Name = "DevOps-Challenge-Public_Route-Table"
    }
}

// Route Table Association
//resource "aws_route_table_association" "default" {
//  subnet_id = var.public_subnet_cidr.id
//  route_table_id = var.public_subnet_cidr.id
//  
//}

// IGW
resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.default.id

    tags     = {
        Name = "DevOps-Challenge-IGW"
    }
}

// Security Groups
resource "aws_security_group" "web_traffic" {
    name        = "DevOps-Challenge-SG"
    description = "Ingress for Web traffic"
    vpc_id      = aws_vpc.default.id

    dynamic "ingress" {
     iterator = port
     for_each = var.ingress_ports
     content {
       from_port   = port.value
       to_port     = port.value
       protocol    = "TCP"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }
}

output "checklist" {
  value = [ for i in var.ingress_ports : "Port ${i} expected to be open"]
}

output "expected" {
  value = aws_security_group.web_traffic[*].ingress
}