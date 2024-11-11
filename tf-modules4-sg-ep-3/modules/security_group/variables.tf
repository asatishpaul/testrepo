variable "sg_name" {
  description = "The name of the security group."
  type        = string
}

variable "sg_description" {
  description = "Description of the security group."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for VPC endpoints."
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for VPC endpoints."
  type        = list(string)
}

variable "enable_network_access" {
  description = "Boolean to enable or disable network access rule (port 33)."
  type        = bool
}

variable "enable_internal_vpc_access" {
  description = "Boolean to enable or disable internal VPC access rule (port 33)."
  type        = bool
}

variable "enable_vpc_endpoint_access" {
  description = "List of VPC endpoints to enable."
  type        = list(string)
}

variable "custom_ingress_ports" {
  description = "Custom ingress ports for additional rules."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
}

variable "custom_egress_ports" {
  description = "Custom egress ports for additional rules."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
}

variable "enable_gateway_endpoint" {
  description = "Enable/disable specific gateway endpoint access (S3, DynamoDB)."
  type        = list(string)
  default     = []
}