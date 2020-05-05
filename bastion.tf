resource "aws_instance" "blackmamba-bastion-1" {
  ami           = "ami-0f56279347d2fa43e"
  instance_type = "t2.micro"
}