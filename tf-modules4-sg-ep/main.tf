module "my_security_group" {
  source         = "./modules/security_group"
  sg_name        = "my-security-group99"
  sg_description = "My security group for various applications"

  # Now get the IDs from the module's outputs
  vpc_id         = module.my_security_group.vpc_id
  route_table_ids = module.my_security_group.route_table_ids
  subnet_ids     = module.my_security_group.subnet_ids

  # Pass the `rules` variable to the module
  ingress = {
    enable_network_access       = true
    enable_internal_vpc_access  = true
    enable_vpc_endpoint_access  = ["logs", "execute-api"]
    custom = {
      http = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "Allow HTTP traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
      https = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Allow HTTPS traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
      custom_rule = {
        from_port   = 2233
        to_port     = 2233
        protocol    = "tcp"
        description = "Allow traffic on port 2233"
        cidr_blocks = ["10.0.0.0/24"]
      }
      ssh = {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "Allow SSH traffic"
        cidr_blocks = ["192.168.0.0/16"]
      }
      rdp = {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        description = "Allow RDP traffic"
        cidr_blocks = ["172.16.0.0/12"]
      }
      mysql = {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        description = "Allow MySQL traffic"
        cidr_blocks = ["10.1.0.0/16"]
      }
      postgres = {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        description = "Allow PostgreSQL traffic"
        cidr_blocks = ["10.2.0.0/16"]
      }
      icmp_ping = {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        description = "Allow ICMP ping"
        cidr_blocks = ["0.0.0.0/0"]
      }
      dns = {
        from_port   = 53
        to_port     = 53
        protocol    = "udp"
        description = "Allow DNS traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
      smtp = {
        from_port   = 25
        to_port     = 25
        protocol    = "tcp"
        description = "Allow SMTP traffic"
        cidr_blocks = ["10.3.0.0/16"]
      }
      custom_high_port = {
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        description = "Allow high ports for ephemeral traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
    }
  }

  egress = {
    enable_network_access       = true
    enable_internal_vpc_access  = true
    enable_vpc_endpoint_access  = ["logs", "execute-api"]
    custom = {
      all_outbound = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        description = "Allow all outbound traffic"
        cidr_blocks = ["1.0.0.0/8"]
      }
      custom_out = {
        from_port   = 888
        to_port     = 888
        protocol    = "tcp"
        description = "Allow traffic on port 888"
        cidr_blocks = ["10.0.0.0/8"]
      }
      ntp = {
        from_port   = 123
        to_port     = 123
        protocol    = "udp"
        description = "Allow NTP traffic"
        cidr_blocks = ["10.4.0.0/16"]
      }
      https_out = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Allow HTTPS outbound traffic"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ftp_out = {
        from_port   = 21
        to_port     = 21
        protocol    = "tcp"
        description = "Allow FTP traffic"
        cidr_blocks = ["172.16.0.0/12"]
      }
      mysql_out = {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        description = "Allow outbound MySQL traffic"
        cidr_blocks = ["192.168.1.0/24"]
      }
      postgres_out = {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        description = "Allow outbound PostgreSQL traffic"
        cidr_blocks = ["10.2.1.0/24"]
      }
      smb_out = {
        from_port   = 445
        to_port     = 445
        protocol    = "tcp"
        description = "Allow outbound SMB traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
      dns_out = {
        from_port   = 53
        to_port     = 53
        protocol    = "udp"
        description = "Allow outbound DNS traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
      custom_high_port_out = {
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        description = "Allow high ports for outbound ephemeral traffic"
        cidr_blocks = ["10.0.0.0/8"]
      }
    }
  }
}
