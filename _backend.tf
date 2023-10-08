terraform {
  backend "s3" {
    bucket = "tf-iac-backend"
    key    = "terraform-aws/terraform.tfstate"
    region = "us-east-1"
  }
}
