output "bucket_arn" {
  description = "ARN of the S3 bucket."
  value       = aws_s3_bucket.file_gateway_bucket.arn
}

output "gateway_arn" {
  description = "ARN of the Storage Gateway."
  value       = aws_storagegateway_gateway.file_gateway.arn
}
