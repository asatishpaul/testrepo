variable "bucket_name" {
  description = "Name of the S3 bucket for Storage Gateway."
  type        = string
}

variable "gateway_name" {
  description = "Name of the Storage Gateway."
  type        = string
}

variable "gateway_timezone" {
  description = "Timezone for the Storage Gateway."
  type        = string
}

variable "gateway_ip" {
  description = "IP address of the gateway appliance."
  type        = string
}
