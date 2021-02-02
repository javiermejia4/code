terraform {
  backend "s3" {
    bucket  = "remote-state-backend"
    key     = "tfstate.tfstate"
    region  = "us-west-1"
    acl     = "private"
    encrypt = true
  }

}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  write_capacity = 20
  read_capacity  = 20
  attribute {
    name = "LockID"
    type = "S"
  }
}