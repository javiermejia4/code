terraform {
  backend "s3" {
   bucket  = "remote-state-backend"
    key    = "terraform/tfstate.tfstate"
    region = "us-west-1"
  }
}