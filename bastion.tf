resource "aws_instance" "blackmamba-bastion-1" {
  ami                         = var.linux_ami
  instance_type               = var.intance_type
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  count = 1

  subnet_id              = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.allowed_traffic.id]

  user_data = "sudo apt update && sudo apt upgrade -y"

  tags = merge(
    local.common_tags,
    {
      Name = "blackMamba-bastion-${count.index}"
    },
  )
}