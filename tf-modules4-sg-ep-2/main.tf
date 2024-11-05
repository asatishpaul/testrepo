# Root `main.tf`

module "my_security_group" {
  source         = "./modules/security_group"
  sg_name        = "my-security-group99"
  sg_description = "My security group for various applications"

  # Now get the IDs from the module's outputs
  vpc_id         = module.my_security_group.vpc_id
  route_table_ids = module.my_security_group.route_table_ids
  subnet_ids     = module.my_security_group.subnet_ids

  # Pass the `rules` variable to the module
  ingress = [
    {
      enable_network_access       = true
      enable_internal_vpc_access  = true
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
      enable_network_access       = true
      enable_internal_vpc_access  = true
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

# Define rules variable to be passed to the module
variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  default = {
    # Ingress Rules
    http   = [80, 80, "tcp", "Allow HTTP traffic"]
    https  = [443, 443, "tcp", "Allow HTTPS traffic"]
    custom = [2233, 2233, "tcp", "Allow traffic on port 2233"]  # New inbound rule

    # Egress Rules
    all_outbound = [0, 0, "-1", "Allow all outbound traffic"]
    custom_out   = [888, 888, "tcp", "Allow traffic on port 888"]  # New outbound rule
  }
}
