resource "aws_s3_bucket" "s3_backend" {
 bucket = "remote-state-backend"
 acl    = "private"

 versioning {
  enabled      = "true"
 }
 force_destroy = "true"
}

