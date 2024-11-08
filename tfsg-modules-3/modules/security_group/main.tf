# `modules/security_group/main.tf`

provider "aws" {
  region = "eu-north-1"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/ironrim/eu-north-1/vpc_id"
}

data "aws_ssm_parameter" "route_table_ids" {
  name = "/ironrim/eu-north-1/route_table_ids"
}

data "aws_ssm_parameter" "subnet_ids" {
  name = "/ironrim/eu-north-1/subnet_ids"
}

locals {
  route_table_ids = split(",", data.aws_ssm_parameter.route_table_ids.value)
  subnet_ids = split(",", data.aws_ssm_parameter.subnet_ids.value)
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
          cidr_blocks = rule.enable_network_access ? ["10.0.0.0/8"] : ["127.0.0.1/32"]
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
          cidr_blocks = rule.enable_network_access ? ["10.0.0.0/8"] : ["127.0.0.1/32"]
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
  vpc_endpoint_type  = "Interface"
  subnet_ids         = local.subnet_ids
  security_group_ids = [aws_security_group.aws_security_manual.id]

  tags = {
    Name = "Logs VPC Endpoint"
  }
}

resource "aws_vpc_endpoint" "api_gateway" {
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  service_name       = "com.amazonaws.eu-north-1.execute-api"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = local.subnet_ids
  security_group_ids = [aws_security_group.aws_security_manual.id]

  tags = {
    Name = "API Gateway VPC Endpoint"
  }
}
