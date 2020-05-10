resource "aws_s3_bucket" "s3_backend" {
 bucket = "remote-state-backend"
 acl    = "private"

 versioning {
  enabled      = "true"
 }
 force_destroy = "true"
}

terraform {
  backend "s3" {
   bucket  = "remote-state-backend"
    key    = "terraform/tfstate.tfstate"
    region = "us-west-1"
  }
}

