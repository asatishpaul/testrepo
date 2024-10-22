import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws"; 
import { SecurityGroup, SecurityGroupRule } from "@cdktf/provider-aws/lib/vpc"; 

class MyStack extends TerraformStack {
  constructor(scope: Construct, name: string) {
    super(scope, name);

    new AwsProvider(this, "AWS", {
      region: "eu-north-1", 
    });

    const securityGroup = new SecurityGroup(this, "db_security_group", {
      name: "db-security-group",
      description: "Security group for the database",
      vpcId: "vpc-0ff7a8c481a69cbce", 
    });

    // Rule for CIDR Blocks
    new SecurityGroupRule(this, "allow_cidr", {
      type: "ingress",
      fromPort: 3306, 
      toPort: 3306, 
      protocol: "tcp",
      cidrBlocks: ["10.0.0.0/24"], 
      securityGroupId: securityGroup.id,
    });

    // Use existing prefix list ID
    const prefixListId = "pl-0eefc4516b1220514"; // Your existing prefix list ID

    // Rule for allowing traffic from the prefix list
    new SecurityGroupRule(this, "allow_prefix_list", {
      type: "ingress",
      fromPort: 8083,
      toPort: 8083,
      protocol: "tcp",
      securityGroupId: securityGroup.id,
      prefixListIds: [prefixListId], // Reference the existing prefix list ID
    });

    // Rule for Destination Security Group
    new SecurityGroupRule(this, "allow_dest_security_group", {
      type: "ingress",
      fromPort: 8081,
      toPort: 8081,
      protocol: "tcp",
      securityGroupId: securityGroup.id, // Reference the same security group
      sourceSecurityGroupId: "sg-028cf6074bb942d5c",
    });

    // Rule for Self-Reference
    new SecurityGroupRule(this, "allow_self_reference", {
      type: "ingress",
      fromPort: 23,
      toPort: 23,
      protocol: "tcp",
      securityGroupId: securityGroup.id,
      cidrBlocks: ["10.0.0.0/24"],
    });

    // Restrict outbound traffic to a specific CIDR block (e.g., internal network)
    new SecurityGroupRule(this, "restrict_egress", {
      type: "egress",
      fromPort: 8080,
      toPort: 8080,
      protocol: "tcp",
      cidrBlocks: ["192.168.0.0/16"], 
      securityGroupId: securityGroup.id,
    });

    // Allow outbound traffic to another security group
    new SecurityGroupRule(this, "egress_to_another_sg", {
      type: "egress",
      fromPort: 443,
      toPort: 443,
      protocol: "tcp",
      securityGroupId: securityGroup.id,
      sourceSecurityGroupId: "sg-028cf6074bb942d5c", 
    });
  }
}

const app = new App();
new MyStack(app, "aws-db-sg-cdktf");
app.synth();
