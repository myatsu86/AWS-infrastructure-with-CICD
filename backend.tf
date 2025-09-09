terraform {
  backend "s3" {
    bucket = "multi-tier-aws-tf-state"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}
