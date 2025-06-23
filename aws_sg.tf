data "aws_ssm_parameter" "vpc_id" {
    name = "/org/member/vpc_id"
  }
  
  data "aws_vpc" "selected" {
    id = data.aws_ssm_parameter.vpc_id.value
  }
  
  resource "aws_security_group" "security_group_manual" {
    name        = var.sg_name
    description = var.sg_description
    vpc_id      = data.aws_ssm_parameter.vpc_id.value
  
    tags = {
      Name = var.sg_name
    }
  
    # Egress rules for CIDR blocks
    dynamic "egress" {
      for_each = var.egress_rules_cidr
      content {
        from_port   = egress.value["from_port"]
        to_port     = egress.value["to_port"]
        protocol    = egress.value["protocol"]
        cidr_blocks = egress.value["cidr_blocks"]
        description = egress.value["description"]
      }
    }
  
    # Egress rules for prefix lists
    dynamic "egress" {
      for_each = var.egress_rules_prefix_list
      content {
        from_port       = egress.value["from_port"]
        to_port         = egress.value["to_port"]
        protocol        = egress.value["protocol"]
        prefix_list_ids = egress.value["prefix_lists"]
        description     = egress.value["description"]
      }
    }
  
    # Egress rules for destination security groups
    dynamic "egress" {
      for_each = var.egress_rules_destination_security_group
      content {
        from_port       = egress.value["from_port"]
        to_port         = egress.value["to_port"]
        protocol        = egress.value["protocol"]
        security_groups = [egress.value["destination_security"]]
        description     = egress.value["description"]
      }
    }
  
    # Ingress rules for CIDR blocks
    dynamic "ingress" {
      for_each = var.ingress_rules_cidr
      content {
        from_port   = ingress.value["from_port"]
        to_port     = ingress.value["to_port"]
        protocol    = ingress.value["protocol"]
        cidr_blocks = ingress.value["cidr_blocks"]
        description = ingress.value["description"]
      }
    }
  
    # Ingress rules for prefix lists
    dynamic "ingress" {
      for_each = var.ingress_rules_prefix_list
      content {
        from_port       = ingress.value["from_port"]
        to_port         = ingress.value["to_port"]
        protocol        = ingress.value["protocol"]
        prefix_list_ids = ingress.value["prefix_lists"]
        description     = ingress.value["description"]
      }
    }
  
    # Ingress rules for VPC CIDR blocks
    dynamic "ingress" {
      for_each = var.ingress_rules_vpc
      content {
        from_port   = ingress.value["from_port"]
        to_port     = ingress.value["to_port"]
        protocol    = ingress.value["protocol"]
        cidr_blocks = [data.aws_vpc.selected.cidr_block]
        description = format("%s VPC", data.aws_vpc.selected.tags["Name"])
      }
    }
  
    # Ingress rules for source security groups
    dynamic "ingress" {
      for_each = var.ingress_rules_source_security_group
      content {
        from_port       = ingress.value["from_port"]
        to_port         = ingress.value["to_port"]
        protocol        = ingress.value["protocol"]
        security_groups = ingress.value["source_security"]
        description     = ingress.value["description"]
      }
    }
  
    # Ingress rules for self-reference
    dynamic "ingress" {
      for_each = var.ingress_rules_self
      content {
        from_port   = ingress.value["from_port"]
        to_port     = ingress.value["to_port"]
        protocol    = ingress.value["protocol"]
        self        = true
        description = "Self"
      }
    }
  }

##
