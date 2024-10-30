sg_name        = "my-security-group"
sg_description = "This is a security group for the application."

egress_rules_cidr = [{
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow HTTP traffic"
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allw HTTPS traffic"
  }
]
ingress_rules_cidr = [{
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow SSH access from internal network"
  }
]

egress_rules_prefix_list                 = []
ingress_rules_prefix_list                = []

egress_rules_destination_security_group = [
  {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    destination_security = "sg-015938f1cf0c6ca31"  
    description = "Allow MySQL traffic"
  }
]

ingress_rules_destination_security_group = [
  {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security = ["sg-015938f1cf0c6ca31"]  
    description = "Allow traffic from SonarQube"
  }
]

ingress_rules_self = [
  {
    from_port = 8083
    to_port = 8083
    protocol = "tcp"
  }
]