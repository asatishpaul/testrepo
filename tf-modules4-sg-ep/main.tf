# Root `main.tf`

provider "aws" {
  region = "eu-north-1"
}

# Retrieve the VPC ID from SSM
data "aws_ssm_parameter" "vpc_id" {
  name = "/ironrim/eu-north-1/vpc_id"
}

# Retrieve the Route Table IDs from SSM (if applicable)
data "aws_ssm_parameter" "route_table_ids" {
  name = "/ironrim/eu-north-1/route_table_ids" # Adjust according to your setup
}

# Retrieve the Subnet IDs from SSM (if applicable)
data "aws_ssm_parameter" "subnet_ids" {
  name = "/ironrim/eu-north-1/subnet_ids" # Adjust according to your setup
}

# Split the Route Table IDs into a list
locals {
  route_table_ids = split(",", data.aws_ssm_parameter.route_table_ids.value) # Assuming they are stored as a comma-separated string
}

# Split the Subnet IDs into a list
locals {
  subnet_ids = split(",", data.aws_ssm_parameter.subnet_ids.value) # Assuming they are stored as a comma-separated string
}

# Security Group Module
module "my_security_group" {
  source         = "./modules/security_group"
  sg_name        = "my-security-group99"
  sg_description = "My security group for various applications"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  route_table_ids = local.route_table_ids
  subnet_ids      = local.subnet_ids

  # Pass the `rules` variable to the module
  ingress = [
    {
      enable_network_access       = false
      enable_internal_vpc_access  = false
      enable_vpc_endpoint_access  = ["logs", "execute-api"]
      custom = [
        for rule_name, rule_values in var.rules : {
          from_port   = rule_values[0]
          to_port     = rule_values[1]
          protocol    = rule_values[2]
          description = rule_values[3]
        } if rule_name == "http" || rule_name == "https" || rule_name == "custom"
      ]
    }
  ]

  egress = [
    {
      enable_network_access       = false
      enable_internal_vpc_access  = false
      enable_vpc_endpoint_access  = ["logs", "execute-api"]
      custom = [
        for rule_name, rule_values in var.rules : {
          from_port   = rule_values[0]
          to_port     = rule_values[1]
          protocol    = rule_values[2]
          description = rule_values[3]
        } if rule_name == "all_outbound" || rule_name == "custom_out"
      ]
    }
  ]
}
