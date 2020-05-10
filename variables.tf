variable "region" {
    default     = "us-west-1"
    description = "AWS Region"
}

variable "vpc_cidr" {
    default     = "10.0.0.0/16"
    description = "VPC CIDR"
}

variable "public_subnet_1_cidr" {
    description = "Public Subnet 1 CIDR"
    default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
    description = "Public Subnet 2 CIDR"
    default     = "10.0.3.0/24"
}

variable "private_subnet_1_cidr" {
    description = "Private Subnet 1 CIDR"
    default     = "10.0.2.0/24"
}

variable "private_subnet_2_cidr" {
    description = "Private Subnet 2 CIDR"
    default     = "10.0.4.0/24"
}

variable "ingress_ports" {
    type        = list(number)
    description = "ilst of ingress ports"
    default     = [22]
}

variable "key_pair_name" {
    default = "CloudyKey"
}

variable "Name" {
    description = "Name"
    default     = "BlackMamba"
}
