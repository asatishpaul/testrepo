variable "sg_name" {
  description = "my-security-group"
  type        = string
  default     = "my-security-group"
}

variable "sg_description" {
  description = "my-security-group"
  type        = string
  default     = "my-security-group"
}

#CIDR blocks
variable "egress_rules_cidr" {
  description = "List of Egress rules for CIDR blocks"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "ingress_rules_cidr" {
  description = "List of Ingress rules for CIDR blocks"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

#Prefix Lists
variable "egress_rules_prefix_list" {
  description = "List of egress rules for prefix lists"
  type = list(object({
    from_port    = number
    to_port      = number
    protocol     = string
    prefix_lists = list(string)
    description  = string
  }))
}

variable "ingress_rules_prefix_list" {
  description = "List of ingress rules for prefix lists"
  type = list(object({
    from_port    = number
    to_port      = number
    protocol     = string
    prefix_lists = list(string)
    description  = string
  }))
}

#destination security groups
variable "egress_rules_destination_security_group" {
  description = "List of egress rules for destination security group"
  type = list(object({
    from_port                  = number
    to_port                    = number
    protocol                   = string
    destination_security = string
    description                = string
  }))
}

variable "ingress_rules_destination_security_group" {
  description = "List of ingress rules for destination security group"
  type = list(object({
    from_port             = number
    to_port               = number
    protocol              = string
    source_security = list(string)
    description           = string
  }))
}

#self-referencing ingress rules
variable "ingress_rules_self" {
  description = "List of ingress rules for self-reference"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}