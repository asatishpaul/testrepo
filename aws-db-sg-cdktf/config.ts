// config.ts
export const config = {
    region: "eu-north-1",
    vpcId: "vpc-0ff7a8c481a69cbce",
    dbSecurityGroupName: "db-security-group",
    ingressPorts: {
      mysql: {
        fromPort: 3306,
        toPort: 3306,
      },
      http: {
        fromPort: 8083,
        toPort: 8083,
      },
      app: {
        fromPort: 8081,
        toPort: 8081,
      },
      self: {
        fromPort: 23,
        toPort: 23,
      },
    },
    egressPorts: {
      internal: {
        fromPort: 8080,
        toPort: 8080,
        cidrBlock: "192.168.0.0/16",
      },
      external: {
        fromPort: 443,
        toPort: 443,
        targetSG: "sg-028cf6074bb942d5c",
      },
    },
    prefixListId: "pl-0e364e753a2ba1157", // Your existing prefix list ID
    cidrBlocks: {
      allowCidr: ["10.0.0.0/24"], // CIDR blocks for ingress rules
      allowSelfReference: ["10.0.0.0/24"], // CIDR blocks for self-reference
    },
  };
  