variable "bucket_name" {
  description = "Name of the S3 bucket."
  type        = string
  default     = "my-storage-gateway-bucket"
}

variable "gateway_name" {
  description = "Name of the Storage Gateway."
  type        = string
  default     = "my-file-gateway"
}

variable "gateway_timezone" {
  description = "Timezone of the Storage Gateway."
  type        = string
  default     = "GMT"
}

variable "gateway_ip" {
  description = "IP address of the gateway appliance."
  type        = string
}
