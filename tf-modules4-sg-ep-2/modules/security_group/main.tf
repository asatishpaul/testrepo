# `modules/security_group/main.tf`

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

resource "aws_security_group" "aws_security_manual" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  # Ingress Rules
  dynamic "ingress" {
    for_each = flatten([
      for rule in var.ingress : [
        for custom_rule in rule.custom : {
          from_port   = custom_rule.from_port
          to_port     = custom_rule.to_port
          protocol    = custom_rule.protocol
          cidr_blocks = rule.enable_network_access ? ["10.0.0.0/8"] : []  # Conditional CIDR block
          description = custom_rule.description
        }
      ]
    ])

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  # Egress Rules
  dynamic "egress" {
    for_each = flatten([
      for rule in var.egress : [
        for custom_rule in rule.custom : {
          from_port   = custom_rule.from_port
          to_port     = custom_rule.to_port
          protocol    = custom_rule.protocol
          cidr_blocks = rule.enable_network_access ? ["10.0.0.0/8"] : []  # Conditional CIDR block
          description = custom_rule.description
        }
      ]
    ])

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  service_name       = "com.amazonaws.eu-north-1.logs"
  vpc_endpoint_type  = "Interface"  # Specify the endpoint type
  subnet_ids         = local.subnet_ids  # Pass the list of subnet IDs
  security_group_ids = [aws_security_group.aws_security_manual.id]  # Use your security group ID

  # Optionally add tags
  tags = {
    Name = "Logs VPC Endpoint"
  }
}

resource "aws_vpc_endpoint" "api_gateway" {
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  service_name       = "com.amazonaws.eu-north-1.execute-api"
  vpc_endpoint_type  = "Interface"  # Specify the endpoint type
  subnet_ids         = local.subnet_ids  # Pass the list of subnet IDs
  security_group_ids = [aws_security_group.aws_security_manual.id]  # Use your security group ID

  # Optionally add tags
  tags = {
    Name = "API Gateway VPC Endpoint"
  }
}
