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
  subnet_ids      = split(",", data.aws_ssm_parameter.subnet_ids.value)
}

resource "aws_security_group" "aws_security_manual" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  dynamic "ingress" {
    for_each = [
      {
        from_port   = 111
        to_port     = 111
        protocol    = "tcp"
        cidr_blocks = var.enable_network_access ? ["10.0.0.0/8"] : []
        description = "Ingress rule for network access (port 111)"
      },
      {
        from_port   = 222
        to_port     = 222
        protocol    = "tcp"
        cidr_blocks = var.enable_internal_vpc_access ? ["10.0.0.0/8"] : []
        description = "Ingress rule for internal VPC access (port 222)"
      }
    ]

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "ingress" {
    for_each = var.custom_ingress_ports

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.custom_egress_ports

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
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

# VPC Gateway Endpoints for S3 and DynamoDB
resource "aws_vpc_endpoint" "s3_gateway" {
  count            = contains(var.enable_gateway_endpoint, "s3") ? 1 : 0
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  service_name     = "com.amazonaws.eu-north-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids  = local.route_table_ids

  tags = {
    Name = "S3 Gateway Endpoint"
  }
}

resource "aws_vpc_endpoint" "dynamodb_gateway" {
  count            = contains(var.enable_gateway_endpoint, "dynamodb") ? 1 : 0
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  service_name     = "com.amazonaws.eu-north-1.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids  = local.route_table_ids

  tags = {
    Name = "DynamoDB Gateway Endpoint"
  }
}