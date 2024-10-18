sg_name = "my-security-group"
sg_description = "This is a security group for the application."

egress_rules_cidr = [ {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow HTTP traffic"
  },
  {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allw HTTPS traffic"
  } 
]
ingress_rules_cidr = [ {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow SSH access from internal network"
  } 
]

egress_rules_prefix_list = []
ingress_rules_prefix_list = []
egress_rules_destination_security_group = []
ingress_rules_destination_security_group = []
ingress_rules_self = []