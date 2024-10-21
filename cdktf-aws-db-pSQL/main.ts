import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from '@cdktf/provider-aws';
import { SecurityGroup, SecurityGroupRule } from "@cdktf/provider-aws/lib/vpc";

class MySecurityGroupStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // Initialize AWS Provider
    new AwsProvider(this, "AWS", {
      region: "eu-north-1",  
    });

    // Create the Security Group for a database
    const dbSecurityGroup = new SecurityGroup(this, "dbSecurityGroup", {
      name: "db-security-group",
      description: "Security group for RDS PostgreSQL",
      vpcId: "vpc-0ff7a8c481a69cbce",  
    });

    // Allow inbound traffic on port 5432 (PostgreSQL)
    new SecurityGroupRule(this, "dbInBound", {
      type: "ingress",
      fromPort: 5432,
      toPort: 5432,
      protocol: "tcp",
      securityGroupId: dbSecurityGroup.id,
      cidrBlocks: ["0.0.0.0/0"], 
    });

    // Allow all outbound traffic
    new SecurityGroupRule(this, "dbOutBound", {
      type: "egress",
      fromPort: 0,
      toPort: 0,
      protocol: "-1", // -1 represents all protocols
      securityGroupId: dbSecurityGroup.id,
      cidrBlocks: ["0.0.0.0/0"],
    });
  }
}

const app = new App();
new MySecurityGroupStack(app, "aws-dbsec-group");
app.synth();
