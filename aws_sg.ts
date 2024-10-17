module "my-security-group" {
    source = "value"
  
    ingress {
      enable_customer_network_access = true
      enable_internal_vpc_access = true
      enable_vpc_endpoint_access = ["logs", "execute-api"]
      custom = [{
        // optional custom rules can be added here
      }]
    }
  
    egress {
      enable_customer_network_access = true
      enable_internal_vpc_access = true
      enable_vpc_endpoint_access = ["logs", "execute-api"]
      custom = [{
        // optional custom rules can be added here
      }]
    }
  }
