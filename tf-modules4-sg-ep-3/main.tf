module "my_security_group" { 
  source         = "./modules/security_group"
  sg_name        = "my-security-group99"
  sg_description = "My security group for various applications"

  vpc_id         = module.my_security_group.vpc_id
  route_table_ids = module.my_security_group.route_table_ids
  subnet_ids     = module.my_security_group.subnet_ids

  enable_network_access       = true
  enable_internal_vpc_access  = true
  enable_vpc_endpoint_access  = ["logs", "execute-api"]
  enable_gateway_endpoint     = ["s3", "dynamodb"]

  custom_ingress_ports = [
    { from_port = 333, to_port = 333, protocol = "tcp", description = "Custom ingress rule for port 888" },
    { from_port = 444, to_port = 444, protocol = "tcp", description = "Custom ingress rule for port 2222" }
  ]

  custom_egress_ports = [
    { from_port = 0, to_port = 0, protocol = "-1", description = "Allow all outbound traffic" }
  ]
}
