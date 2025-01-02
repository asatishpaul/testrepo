provider "aws" {
  region = "ap-south-1"
}

module "s3_bucket" {
  source            = "../modules/s3"
  bucket_name       = "shree-terraform-s3-bucket"
  region            = "ap-south-1"
  enable_versioning = true
}

output "s3_bucket_id" {
  value = module.s3_bucket.bucket_id
}

output "s3_bucket_arn" {
  value = module.s3_bucket.bucket_arn
}
