# main.tf
terraform {
  required_providers {
   aws = {
    source  = "hashicorp/aws"
      version = ">= 5.27"
    }
  }
}
resource "aws_s3_bucket" "task3kops" {
  bucket = "task3kops"
  tags = {
    Name = "MyS3BucketkOPS"
  }
}
