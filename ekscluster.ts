import * as cdktf from 'cdktf';
import { Construct } from 'constructs';
import { DceAwsConstruct } from '../core';
import * as aws from '@cdktf/provider-aws';
import * as nullProvider from '../../../.gen/providers/null';
import { TerraformMetaArguments } from 'cdktf';

export interface EksClusterConfig extends cdktf.TerraformMetaArguments {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#id EksCluster#id}.
   *
   * Please be aware that the id field is automatically added to all resources in Terraform providers using a Terraform provider SDK version below 2.
   * If you experience problems setting this value it might not be settable. Please take a look at the provider documentation to ensure it should be settable.
   */
  readonly id?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#name EksCluster#name}.
   */
  readonly name: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#role_arn EksCluster#role_arn}.
   */
  readonly roleArn?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#tags EksCluster#tags}.
   */
  readonly tags?: { [key: string]: string };
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#tags_all EksCluster#tags_all}.
   */
  readonly tagsAll?: { [key: string]: string };
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#version EksCluster#version}.
   */
  readonly version?: string;
  /**
   * Vpc_config block.
   *
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#vpc_config EksCluster#vpc_config}.
   */
  readonly vpcConfig?: EksClusterVpcConfig;
}

export interface EksClusterVpcConfig {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#security_group_ids EksCluster#security_group_ids}.
   */
  readonly securityGroupIds?: string[];
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster#subnet_ids EksCluster#subnet_ids}.
   */
  readonly subnetIds: string[];
}

export interface EksNodeGroupConfig extends cdktf.TerraformMetaArguments {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#ami_type EksNodeGroup#ami_type}.
   */
  readonly amiType?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#capacity_type EksNodeGroup#capacity_type}.
   */
  readonly capacityType?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#disk_size EksNodeGroup#disk_size}.
   */
  readonly diskSize?: number;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#force_update_version EksNodeGroup#force_update_version}.
   */
  readonly forceUpdateVersion?: boolean | cdktf.IResolvable;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#instance_types EksNodeGroup#instance_types}.
   */
  readonly instanceTypes?: string[];
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#labels EksNodeGroup#labels}.
   */
  readonly labels?: { [key: string]: string };
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#node_group_name EksNodeGroup#node_group_name}.
   */
  readonly nodeGroupName?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#node_group_name_prefix EksNodeGroup#node_group_name_prefix}.
   */
  readonly nodeGroupNamePrefix?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#node_role_arn EksNodeGroup#node_role_arn}.
   */
  readonly nodeRoleArn?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#release_version EksNodeGroup#release_version}.
   */
  readonly releaseVersion?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#subnet_ids EksNodeGroup#subnet_ids}.
   */
  readonly subnetIds?: string[];
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#tags EksNodeGroup#tags}.
   */
  readonly tags?: { [key: string]: string };
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#tags_all EksNodeGroup#tags_all}.
   */
  readonly tagsAll?: { [key: string]: string };
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#version EksNodeGroup#version}.
   */
  readonly version?: string;
  /**
   * Launch_template block.
   *
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#launch_template EksNodeGroup#launch_template}.
   */
  readonly launchTemplate?: EksNodeGroupLaunchTemplate;
  /**
   * Scaling_config block.
   *
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#scaling_config EksNodeGroup#scaling_config}.
   */
  readonly scalingConfig?: EksNodeGroupScalingConfig;
  /**
   * Taint block.
   *
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#taint EksNodeGroup#taint}.
   */
  readonly taint?: EksNodeGroupTaint[] | cdktf.IResolvable;
  /**
   * Update_config block.
   *
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#update_config EksNodeGroup#update_config}.
   */
  readonly updateConfig?: EksNodeGroupUpdateConfig;
}

export interface EksNodeGroupUpdateConfig {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#max_unavailable EksNodeGroup#max_unavailable}.
   */
  readonly maxUnavailable?: number;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#max_unavailable_percentage EksNodeGroup#max_unavailable_percentage}.
   */
  readonly maxUnavailablePercentage?: number;
}

export interface EksNodeGroupTaint {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#effect EksNodeGroup#effect}.
   */
  readonly effect: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#key EksNodeGroup#key}.
   */
  readonly key: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#value EksNodeGroup#value}.
   */
  readonly value?: string;
}

export interface EksNodeGroupScalingConfig {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#desired_size EksNodeGroup#desired_size}.
   */
  readonly desiredSize: number;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#max_size EksNodeGroup#max_size}.
   */
  readonly maxSize: number;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#min_size EksNodeGroup#min_size}.
   */
  readonly minSize: number;
}

export interface EksNodeGroupLaunchTemplate {
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#id EksNodeGroup#id}.
   *
   * Please be aware that the id field is automatically added to all resources in Terraform providers using a Terraform provider SDK version below 2.
   * If you experience problems setting this value it might not be settable. Please take a look at the provider documentation to ensure it should be settable.
   */
  readonly id?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#name EksNodeGroup#name}.
   */
  readonly name?: string;
  /**
   * Docs at Terraform Registry: {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group#version EksNodeGroup#version}.
   */
  readonly version: string;
}
/**
 * Properties for the Cluster.
 */
export interface DceEksClusterProps extends TerraformMetaArguments {
  /**
   * The properties the cluster will leverage.
   */
  readonly clusterProps: EksClusterConfig;
  /**
   * The properties that node group will leverage.
   */
  readonly nodeGroupProps?: EksNodeGroupConfig;
  /**
   * The ARN of the KMS Key used to encrypt the EKS Cluster.
   */
  readonly kmsKeyArn?: string;
  /**
   * This means that the additionalCusterRolePolicies property should contain an array of AWS IAM policy statements.
   */
  readonly additionalCusterRolePolicies?: Array<Statement>;

  /**
   * Specifies the number of days you want to retain log events in the specified log group.
   * Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827,
   *  2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are
   *  always retained and never expire.
   */
  readonly logRetentionInDays?: number;
}

/**
 * Allow users to add additional policy/es to EKS Cluster.
 */
export interface Statement {
  /**
   * The Action element describes the specific action or actions that will be allowed or denied.
   */
  readonly action: string[];
  /**
   * The Resource element specifies the object or objects that the statement covers.
   */
  readonly resource: string[];
  /**
   * The Effect element is required and specifies whether the statement results in an allow or an explicit deny..
   */
  readonly effect: string;
}

/**
 * The Amazon EKS Cluster with a default nodegroup.
 * 
 * import Tabs from '@theme/Tabs';
 * import TabItem from '@theme/TabItem';
 * import CodeBlock from '@theme/CodeBlock';
 * import JSSource from '!!raw-loader!../../jsii-sample-apps/javascript/src/EksClusterStack.ts';
 * 
 * <Tabs>
 *  <TabItem value="Typescript">
 *    <CodeBlock language="ts" showLineNumbers>{JSSource}</CodeBlock>
 *  </TabItem>
 * </Tabs>
 *
 */
export class DceEksCluster extends DceAwsConstruct {
  /**
   * Represents a aws_eks_cluster.
   * See {@link https://www.terraform.io/docs/providers/aws/r/eks_cluster aws_eks_cluster}.
   */
  readonly cluster: aws.eksCluster.EksCluster;
  /**
   * Represents a aws_eks_node_group.
   * See {@link https://www.terraform.io/docs/providers/aws/r/eks_node_group aws_eks_node_group}.
   */
  readonly nodeGroup: aws.eksNodeGroup.EksNodeGroup;
  /**
   * The ARN of the KMS Key used to encrypt the EKS Cluster.
   */
  readonly kmsKeyArn: string;

  constructor(scope: Construct, id: string, props: DceEksClusterProps) {
    super(scope, id);

    this.kmsKeyArn = props.kmsKeyArn ?? new aws.kmsKey.KmsKey(this, 'kmskey').arn;

    const subnets = this.allPrivateSubnets();
    const region = this.region(props.provider as aws.provider.AwsProvider);

    const clusterLogGroup = new aws.cloudwatchLogGroup.CloudwatchLogGroup(this, 'cluster_log_group', {
      name: `/aws/eks/${props.clusterProps.name}/cluster`,
      retentionInDays: props.logRetentionInDays
    });

    // create the cluster
    this.cluster = new aws.eksCluster.EksCluster(this, 'EksCluster', {
      ...props.clusterProps,
      dependsOn: [clusterLogGroup],
      enabledClusterLogTypes: ['api', 'audit', 'authenticator', 'controllerManager', 'scheduler'],
      encryptionConfig: {
        provider: {
          keyArn: this.kmsKeyArn
        },
        resources: ['secrets']
      },
      vpcConfig: {
        // the cluster should associate with all available subnets
        ...props.clusterProps.vpcConfig,
        subnetIds: props.clusterProps.vpcConfig?.subnetIds ?? subnets.ids,
        endpointPublicAccess: true,
        endpointPrivateAccess: true
      },
      roleArn: props.clusterProps.roleArn ?? this.createClusterRole(props.additionalCusterRolePolicies ?? []).arn
    });

    this.addVpcEndpointSecurityGroupRules(this.cluster.vpcConfig.clusterSecurityGroupId, props.clusterProps.name, region);

    this.nodeGroup = new aws.eksNodeGroup.EksNodeGroup(this, 'nodegroup', {
      dependsOn: [this.cluster],
      ...props.nodeGroupProps,
      clusterName: props.clusterProps.name,
      version: props.nodeGroupProps?.version ?? props.clusterProps.version,
      nodeGroupName: props.nodeGroupProps?.nodeGroupName ?? props.clusterProps.name,
      subnetIds: props.nodeGroupProps?.subnetIds ?? subnets.ids,
      scalingConfig: {
        minSize: props.nodeGroupProps?.scalingConfig?.minSize ?? 1,
        maxSize: props.nodeGroupProps?.scalingConfig?.maxSize ?? 2,
        desiredSize: props.nodeGroupProps?.scalingConfig?.desiredSize ?? 1
      },
      nodeRoleArn: props.clusterProps.roleArn ?? this.createNodeGroupRole().arn,
      capacityType: props.nodeGroupProps?.capacityType ?? 'ON_DEMAND'
    });

    new cdktf.TerraformOutput(this, 'KubelctlCommand', {
      value: `aws --region ${region} eks update-kubeconfig --name ${props.clusterProps.name}`
    });
  }

  private addVpcEndpointSecurityGroupRules(clusterSecurityGroupId: string, clusterName: string, region: string) {
    this.addVpceSecurityGroupIngressRule({
      id: 'ecr.api',
      serviceName: `com.amazonaws.${region}.ecr.api`,
      sourceSecurityGroup: clusterSecurityGroupId,
      clusterName
    });

    this.addVpceSecurityGroupIngressRule({
      id: 'ecr.dkr',
      serviceName: `com.amazonaws.${region}.ecr.dkr`,
      sourceSecurityGroup: clusterSecurityGroupId,
      clusterName
    });

    this.addVpceSecurityGroupIngressRule({
      id: 'ec2',
      serviceName: `com.amazonaws.${region}.ec2`,
      sourceSecurityGroup: clusterSecurityGroupId,
      clusterName
    });

    this.addVpceSecurityGroupIngressRule({
      id: 'secretsmanager',
      serviceName: `com.amazonaws.${region}.secretsmanager`,
      sourceSecurityGroup: clusterSecurityGroupId,
      clusterName
    });
  }

  private createNodeGroupRole(): aws.iamRole.IamRole {
    const { accountId } = this.callerIdentity();
    const eksWorkerNodePolicy = new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, 'AmazonEKSWorkerNodePolicy', {
      name: 'AmazonEKSWorkerNodePolicy'
    });

    const containerRegisteryPolicy = new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, 'AmazonEC2ContainerRegistryReadOnly', {
      name: 'AmazonEC2ContainerRegistryReadOnly'
    });

    const workerPolicy = new aws.iamPolicy.IamPolicy(this, 'cnc-devops-eks-worker-policy', {
      policy: JSON.stringify({
        Version: '2012-10-17',
        Statement: [
          {
            Sid: 'VisualEditor0',
            Effect: 'Allow',
            Action: ['kms:Decrypt', 'secretsmanager:GetSecretValue', 'secretsmanager:DescribeSecret', 'kms:Encrypt', 'kms:GenerateDataKey', 'kms:DescribeKey'],
            Resource: [`arn:aws:kms:*:${accountId}:key/*`, `arn:aws:secretsmanager:*:${accountId}:secret:*`]
          },
          {
            Action: ['kms:ListAliases', 'kms:ListKeys'],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: ['cloudwatch:GetMetricData'],
            Resource: '*',
            Effect: 'Allow'
          }
        ]
      })
    });

    const role = new aws.iamRole.IamRole(this, 'cnc-devops-eks-worker-role', {
      assumeRolePolicy: JSON.stringify({
        Version: '2012-10-17',
        Statement: [
          {
            Effect: 'Allow',
            Principal: {
              Service: 'ec2.amazonaws.com'
            },
            Action: 'sts:AssumeRole'
          }
        ]
      }),
      managedPolicyArns: [
        workerPolicy.arn,
        eksWorkerNodePolicy.arn,
        containerRegisteryPolicy.arn,
        new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, 'AmazonEKS_CNI_Policy', {
          name: 'AmazonEKS_CNI_Policy'
        }).arn,
        new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, 'AmazonEC2RoleforSSM', {
          name: 'AmazonEC2RoleforSSM'
        }).arn
      ]
    });

    return role;
  }
  private createClusterRole(additionalProps: Array<Statement>): aws.iamRole.IamRole {
    const { accountId } = this.callerIdentity();

    const clusterPolicy = new aws.iamPolicy.IamPolicy(this, 'cnc-devops-eks-cluster-policy', {
      policy: JSON.stringify({
        Version: '2012-10-17',
        Statement: [
          {
            Action: ['iam:GetRole', 'iam:CreateServiceLinkedRole'],
            Resource: [
              `arn:aws:iam::${accountId}:role/aws-service-role/eks-fargate.amazonaws.com/AWSServiceRoleForAmazonEKSForFargate`,
              `arn:aws:iam::${accountId}:role/aws-service-role/eks-nodegroup.amazonaws.com/AWSServiceRoleForAmazonEKSNodegroup`,
              `arn:aws:iam::${accountId}:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS`
            ],
            Effect: 'Allow'
          }
        ]
      })
    });

    const controllerPolicy = new aws.iamPolicy.IamPolicy(this, 'cnc-eks-alb-ingress-controller-sa-policy', {
      policy: JSON.stringify({
        Version: '2012-10-17',
        Statement: [
          ...additionalProps,
          {
            Action: ['acm:ListCertificates'],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: ['acm:DescribeCertificate', 'acm:GetCertificate'],
            Resource: [`arn:aws:acm:*:${accountId}:certificate/*`],
            Effect: 'Allow'
          },
          {
            Action: ['ec2:CreateTags', 'ec2:DeleteTags'],
            Resource: [`arn:aws:ec2:*:${accountId}:security-group/*`, 'arn:aws:ec2:*::image/*'],
            Effect: 'Allow'
          },
          {
            Action: ['ec2:ModifyInstanceAttribute', 'ec2:ModifyNetworkInterfaceAttribute'],
            Resource: [`arn:aws:ec2:*:${accountId}:network-interface/*`],
            Effect: 'Allow'
          },
          {
            Action: [
              'ec2:DescribeAvailabilityZones',
              'ec2:DescribeAccountAttributes',
              'ec2:DescribeAddresses',
              'ec2:DescribeInstanceStatus',
              'ec2:DescribeInstances',
              'ec2:DescribeInternetGateways',
              'ec2:DescribeNetworkInterfaces',
              'ec2:DescribeSecurityGroups',
              'ec2:DescribeSubnets',
              'ec2:DescribeTags',
              'ec2:DescribeVpcs'
            ],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: ['ec2:CreateSecurityGroup', 'ec2:AuthorizeSecurityGroupIngress', 'ec2:DeleteSecurityGroup', 'ec2:RevokeSecurityGroupIngress'],
            Resource: `arn:aws:ec2:*:${accountId}:security-group/*`,
            Effect: 'Allow'
          },
          {
            Action: [
              'elasticloadbalancing:DescribeListenerCertificates',
              'elasticloadbalancing:DescribeListeners',
              'elasticloadbalancing:DescribeLoadBalancerAttributes',
              'elasticloadbalancing:DescribeLoadBalancers',
              'elasticloadbalancing:DescribeRules',
              'elasticloadbalancing:DescribeSSLPolicies',
              'elasticloadbalancing:DescribeTags',
              'elasticloadbalancing:DescribeTargetGroupAttributes',
              'elasticloadbalancing:DescribeTargetGroups',
              'elasticloadbalancing:DescribeTargetHealth',
              'elasticloadbalancing:SetWebACL'
            ],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: [
              'elasticloadbalancing:AddListenerCertificates',
              'elasticloadbalancing:CreateRule',
              'elasticloadbalancing:DeleteListener',
              'elasticloadbalancing:ModifyListener',
              'elasticloadbalancing:RemoveListenerCertificates'
            ],
            Resource: [`arn:aws:elasticloadbalancing:*:${accountId}:listener/app/*/*/*`, `arn:aws:elasticloadbalancing:*:${accountId}:listener/net/*/*/*`],
            Effect: 'Allow'
          },
          {
            Action: [
              'elasticloadbalancing:AddTags',
              'elasticloadbalancing:CreateTargetGroup',
              'elasticloadbalancing:DeleteTargetGroup',
              'elasticloadbalancing:DeregisterTargets',
              'elasticloadbalancing:ModifyTargetGroup',
              'elasticloadbalancing:ModifyTargetGroupAttributes',
              'elasticloadbalancing:RegisterTargets',
              'elasticloadbalancing:RemoveTags'
            ],
            Resource: [`arn:aws:elasticloadbalancing:*:${accountId}:targetgroup/*/*`],
            Effect: 'Allow'
          },
          {
            Action: [
              'elasticloadbalancing:AddTags',
              'elasticloadbalancing:CreateListener',
              'elasticloadbalancing:CreateLoadBalancer',
              'elasticloadbalancing:DeleteLoadBalancer',
              'elasticloadbalancing:ModifyLoadBalancerAttributes',
              'elasticloadbalancing:RemoveTags',
              'elasticloadbalancing:SetIpAddressType',
              'elasticloadbalancing:SetSecurityGroups',
              'elasticloadbalancing:SetSubnets'
            ],
            Resource: [`arn:aws:elasticloadbalancing:*:${accountId}:loadbalancer/app/*/*`, `arn:aws:elasticloadbalancing:*:${accountId}:loadbalancer/net/*/*`],
            Effect: 'Allow'
          },
          {
            Action: ['elasticloadbalancing:DeleteRule', 'elasticloadbalancing:ModifyRule'],
            Resource: [`arn:aws:elasticloadbalancing:*:${accountId}:listener-rule/app/*/*/*/*`, `arn:aws:elasticloadbalancing:*:${accountId}:listener-rule/net/*/*/*/*`],
            Effect: 'Allow'
          },
          {
            Action: ['iam:GetServerCertificate'],
            Resource: [`arn:aws:iam::${accountId}:server-certificate/*`],
            Effect: 'Allow'
          },
          {
            Action: ['iam:ListServerCertificates'],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: ['iam:CreateServiceLinkedRole', 'iam:GetRole'],
            Resource: [
              `arn:aws:iam::${accountId}:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing`,
              `arn:aws:iam::${accountId}:role/aws-service-role/globalaccelerator.amazonaws.com/AWSServiceRoleForGlobalAccelerator`
            ],
            Effect: 'Allow'
          },
          {
            Action: ['cognito-idp:DescribeUserPoolClient'],
            Resource: [`arn:aws:cognito-idp:*:${accountId}:userpool/*`],
            Effect: 'Allow'
          },
          {
            Action: ['waf-regional:GetWebACL'],
            Resource: [`arn:aws:waf-regional:*:${accountId}:webacl/*`],
            Effect: 'Allow'
          },
          {
            Action: ['waf-regional:DisassociateWebACL', 'waf-regional:GetWebACLForResource'],
            Resource: [`arn:aws:waf-regional:*:${accountId}:*/*`],
            Effect: 'Allow'
          },
          {
            Action: ['waf-regional:AssociateWebACL'],
            Resource: [`arn:aws:elasticloadbalancing:*:${accountId}:loadbalancer/app/*/*`, `arn:aws:waf-regional:*:${accountId}:webacl/*`],
            Effect: 'Allow'
          },
          {
            Action: ['tag:GetResources', 'tag:TagResources'],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: ['wafv2:AssociateWebACL', 'wafv2:GetWebACL'],
            Resource: [`arn:aws:wafv2:us-east-1:${accountId}:*/webacl/*/*`],
            Effect: 'Allow'
          },
          {
            Action: ['wafv2:AssociateWebACL', 'wafv2:DisassociateWebACL', 'wafv2:GetWebACLForResource'],
            Resource: ['arn:aws:apigateway:*::/restapis/*/stages/prod', `arn:aws:elasticloadbalancing:*:${accountId}:loadbalancer/app/*/*`, `arn:aws:wafv2:*:${accountId}:regional/webacl/*`],
            Effect: 'Allow'
          },
          {
            Action: ['shield:DescribeSubscription', 'shield:GetSubscriptionState', 'shield:ListProtections'],
            Resource: '*',
            Effect: 'Allow'
          },
          {
            Action: ['shield:CreateProtection', 'shield:DeleteProtection', 'shield:DescribeProtection'],
            Resource: [`arn:aws:shield::${accountId}:protection/*`],
            Effect: 'Allow'
          },
          {
            Action: ['wafv2:ListWebACLs'],
            Resource: '*',
            Effect: 'Allow'
          }
        ]
      })
    });

    const policy = new aws.dataAwsIamPolicy.DataAwsIamPolicy(this, 'AmazonEKSClusterPolicy', {
      name: 'AmazonEKSClusterPolicy'
    });

    const role = new aws.iamRole.IamRole(this, 'ClusterRole', {
      assumeRolePolicy: JSON.stringify({
        Version: '2012-10-17',
        Statement: [
          {
            Action: 'sts:AssumeRole',
            Effect: 'Allow',
            Sid: '',
            Principal: {
              Service: 'eks.amazonaws.com'
            }
          }
        ]
      }),
      managedPolicyArns: [clusterPolicy.arn, controllerPolicy.arn, policy.arn]
    });

    return role;
  }

  private addVpceSecurityGroupIngressRule(props: IAddAgProps) {
    const endpointSecurityGroup = cdktf.Fn.element(this.interfaceVpcEndpoint(props.id, props.serviceName).securityGroupIds, 0);

    new nullProvider.resource.Resource(this, `${props.id}-ingress-script`, {
      triggers: {
        endpointSecurityGroup: endpointSecurityGroup,
        sourceSecurityGroup: props.sourceSecurityGroup,
        serviceName: props.serviceName
      },
      provisioners: [
        {
          type: 'local-exec',
          when: 'create',
          command: `aws ec2 authorize-security-group-ingress \
          --group-id ${endpointSecurityGroup}  \
          --protocol tcp \
          --port 443 \
          --source-group ${props.sourceSecurityGroup} \
          --no-verify-ssl || echo 'already installed'`
        },
        {
          type: 'local-exec',
          when: 'destroy',
          command: `aws ec2 revoke-security-group-ingress \
          --group-id \${self.triggers.endpointSecurityGroup}  \
          --protocol tcp \
          --port 443 \
          --source-group \${self.triggers.sourceSecurityGroup} \
          --no-verify-ssl || echo 'already removed'`
        }
      ]
    });
  }
}

export interface IAddAgProps {
  id: string;
  serviceName: string;
  sourceSecurityGroup: string;
  clusterName: string;
}
