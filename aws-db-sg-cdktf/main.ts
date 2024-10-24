import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws"; 
import { SecurityGroup, SecurityGroupRule } from "@cdktf/provider-aws/lib/vpc"; 
import { config } from "./config"; // Import the configuration

class MyStack extends TerraformStack {
  constructor(scope: Construct, name: string) {
    super(scope, name);

    // Initialize the AWS provider with region from config
    new AwsProvider(this, "AWS", {
      region: config.region, 
    });

    // Create the security group using the name from config
    const securityGroup = new SecurityGroup(this, "db_security_group", {
      name: config.dbSecurityGroupName,
      description: "Security group for the database",
      vpcId: config.vpcId, 
    });

    // Rule for CIDR Blocks using variables from config
    new SecurityGroupRule(this, "allow_cidr", {
      type: "ingress",
      fromPort: config.ingressPorts.mysql.fromPort,
      toPort: config.ingressPorts.mysql.toPort,
      protocol: "tcp",
      cidrBlocks: config.cidrBlocks.allowCidr, // Reference CIDR blocks from config
      securityGroupId: securityGroup.id,
    });

    // Rule for allowing traffic from the prefix list
    new SecurityGroupRule(this, "allow_prefix_list", {
      type: "ingress",
      fromPort: config.ingressPorts.http.fromPort,
      toPort: config.ingressPorts.http.toPort,
      protocol: "tcp",
      securityGroupId: securityGroup.id,
      prefixListIds: [config.prefixListId], // Reference the Prefix List ID from config
    });

    // Rule for Destination Security Group
    new SecurityGroupRule(this, "allow_dest_security_group", {
      type: "ingress",
      fromPort: config.ingressPorts.app.fromPort,
      toPort: config.ingressPorts.app.toPort,
      protocol: "tcp",
      securityGroupId: securityGroup.id, // Reference the same security group
      sourceSecurityGroupId: "sg-028cf6074bb942d5c",
    });

    // Rule for Self-Reference using CIDR blocks from config
    new SecurityGroupRule(this, "allow_self_reference", {
      type: "ingress",
      fromPort: config.ingressPorts.self.fromPort,
      toPort: config.ingressPorts.self.toPort,
      protocol: "tcp",
      securityGroupId: securityGroup.id,
      cidrBlocks: config.cidrBlocks.allowSelfReference, // Reference CIDR blocks from config
    });

    // Restrict outbound traffic to a specific CIDR block (e.g., internal network)
    new SecurityGroupRule(this, "restrict_egress", {
      type: "egress",
      fromPort: config.egressPorts.internal.fromPort,
      toPort: config.egressPorts.internal.toPort,
      protocol: "tcp",
      cidrBlocks: [config.egressPorts.internal.cidrBlock], 
      securityGroupId: securityGroup.id,
    });

    // Allow outbound traffic to another security group
    new SecurityGroupRule(this, "egress_to_another_sg", {
      type: "egress",
      fromPort: config.egressPorts.external.fromPort,
      toPort: config.egressPorts.external.toPort,
      protocol: "tcp",
      securityGroupId: securityGroup.id,
      sourceSecurityGroupId: config.egressPorts.external.targetSG, 
    });
  }
}

const app = new App();
new MyStack(app, "aws-db-sg-cdktf");
app.synth();
