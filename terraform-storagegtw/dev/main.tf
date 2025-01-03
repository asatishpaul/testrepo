provider "aws" {
  region = "ap-south-1"
}

module "storage_gateway" {
  source = "../modules/sg"

  bucket_name      = "my-storage-gateway-bucket"
  gateway_name     = "my-file-gateway"
  gateway_timezone = "GMT"
  gateway_ip       = "3.110.136.74"
}
