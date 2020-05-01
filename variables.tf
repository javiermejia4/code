variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.2.0/24"
}

variable "ingress_ports" {
    type        = list(number)
    description = "ilst of ingress ports"
    default     = [80,443]
}