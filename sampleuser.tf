module "my-security-group" {
  source = "value"

  name        = "my-sg-name"
  description = "my-description"

  ingress {
    enable_centene_network_access = true
    enable_internal_vpc_access    = true
    enable_vpc_endpoint_access    = ["logs", "execute-api"]
    enable_gateway_endpoint       = ["s3", "dyanmodb"]
    custom = [{
      // optional custom rules can be added here
      from_port   = 443
      to_port     = 443
      protocol    = tcp
      description = "some cool rule"
      cidr_range  = []
      },
      {
        // optional custom rules can be added here
        from_port   = 443
        to_port     = 443
        protocol    = tcp
        description = "some cool rule2"
        ipv6_cidr_blocks  = []
      }
    ]
  }

  egress {
    enable_centene_network_access = true
    enable_internal_vpc_access    = true
    enable_vpc_endpoint_access    = ["logs", "execute-api"]
    custom = [{
      // optional custom rules can be added here
    }]
  }
}
