resource "aws_s3_bucket" "file_gateway_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.file_gateway_bucket.id
  acl    = "private"
}

resource "aws_storagegateway_gateway" "file_gateway" {
  gateway_name     = var.gateway_name
  gateway_timezone = var.gateway_timezone
  gateway_ip_address = var.gateway_ip
  gateway_type     = "FILE_S3"
}

resource "aws_iam_role" "storage_gateway_role" {
  name = "StorageGatewayRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "storagegateway.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "storage_gateway_policy" {
  name = "StorageGatewayPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.file_gateway_bucket.arn,
          "${aws_s3_bucket.file_gateway_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "storage_gateway_role_attach" {
  role       = aws_iam_role.storage_gateway_role.name
  policy_arn = aws_iam_policy.storage_gateway_policy.arn
}

resource "aws_storagegateway_smb_file_share" "smb_share" {
  gateway_arn         = aws_storagegateway_gateway.file_gateway.arn
  location_arn        = aws_s3_bucket.file_gateway_bucket.arn
  role_arn            = aws_iam_role.storage_gateway_role.arn
  default_storage_class = "S3_STANDARD"
  authentication      = "GuestAccess"
}
