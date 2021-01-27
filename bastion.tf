resource "aws_instance" "blackmamba-bastion-1" {
  ami                         = "ami-0f56279347d2fa43e"
  instance_type               = "t2.micro"
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  subnet_id              = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.allowed_traffic.id]

  tags   = {
    Name = "BlackMamba-bastion"
  }

}