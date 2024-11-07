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

variable "ingress" {
  description = "Ingress rules with custom configurations."
  type = object({
    enable_network_access      = bool
    enable_internal_vpc_access = bool
    enable_vpc_endpoint_access = list(string)
    custom = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      description = string
      cidr_blocks = list(string)
    }))
  })
}

variable "egress" {
  description = "Egress rules with custom configurations."
  type = object({
    enable_network_access      = bool
    enable_internal_vpc_access = bool
    enable_vpc_endpoint_access = list(string)
    custom = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      description = string
      cidr_blocks = list(string)
    }))
  })
}
