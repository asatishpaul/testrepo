# `modules/security_group/output.tf`

output "security_group_id" {
  description = "The ID of the security group created"
  value       = aws_security_group.aws_security_manual.id
}

output "security_group_name" {
  description = "The name of the security group created"
  value       = aws_security_group.aws_security_manual.name
}

output "vpc_id" {
  description = "The ID of the VPC associated with the security group"
  value       = aws_security_group.aws_security_manual.vpc_id
}

output "cloudwatch_logs_vpc_endpoint_id" {
  description = "The ID of the CloudWatch Logs VPC endpoint"
  value       = aws_vpc_endpoint.logs.id
}

output "api_gateway_vpc_endpoint_id" {
  description = "The ID of the API Gateway VPC endpoint"
  value       = aws_vpc_endpoint.api_gateway.id
}
