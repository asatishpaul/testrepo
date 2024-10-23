#!/bin/bash

# CSV file path
OUTPUT_FILE="aws_resources_info.csv"

# Headers to CSV file
echo "Resources,IDs,Details" > $OUTPUT_FILE

# Availability Zones
echo "" >> $OUTPUT_FILE
echo "Availability Zones Information:" >> $OUTPUT_FILE
aws ec2 describe-availability-zones --query "AvailabilityZones[*].{ZoneName:ZoneName,State:State,RegionName:RegionName}" --output text | \
while read ZoneName State RegionName; do
    echo "AvailabilityZone,$ZoneName,State: $State, Region: $RegionName" >> $OUTPUT_FILE
done

# VPCs
echo "" >> $OUTPUT_FILE
echo "VPCs Information:" >> $OUTPUT_FILE
aws ec2 describe-vpcs --query "Vpcs[*].{VpcId:VpcId,Tags:Tags[?Key=='Name'].Value | [0],CidrBlock:CidrBlock,State:State}" --output text | \
while read VpcName VpcId CidrBlock State; do
    VpcName=${VpcName:-"N/A"}  # Handle cases where VPC has no name tag
    echo "VPC,$VpcId,Name: $VpcName, CIDR Block: $CidrBlock, State: $State" >> $OUTPUT_FILE
done

# Subnets
echo "" >> $OUTPUT_FILE
echo "Subnets Information:" >> $OUTPUT_FILE
aws ec2 describe-subnets --query "Subnets[*].{SubnetId:SubnetId,VpcId:VpcId,Tags:Tags[?Key=='Name'].Value | [0],CidrBlock:CidrBlock,AvailabilityZone:AvailabilityZone}" --output text | \
while read SubnetName SubnetId VpcId CidrBlock AvailabilityZone; do
    SubnetName=${SubnetName:-"N/A"}  # Handle cases where Subnet has no name tag
    echo "Subnet,$SubnetId,Name: $SubnetName, CIDR Block: $CidrBlock, Availability Zone: $AvailabilityZone" >> $OUTPUT_FILE
done

# Route Tables
echo "" >> $OUTPUT_FILE
echo "Route Tables Information:" >> $OUTPUT_FILE
aws ec2 describe-route-tables --query "RouteTables[*].{RouteTableId:RouteTableId,VpcId:VpcId,Tags:Tags[?Key=='Name'].Value | [0],Routes:Routes}" --output text | \
while read RouteTableName RouteTableId VpcId Routes; do
    RouteTableName=${RouteTableName:-"N/A"}  # Handle cases where Route Table has no name tag
    echo "RouteTable,$RouteTableId,Name: $RouteTableName, Routes: $Routes" >> $OUTPUT_FILE
done

# Security Groups
echo "" >> $OUTPUT_FILE
echo "Security Groups Information:" >> $OUTPUT_FILE
aws ec2 describe-security-groups --query "SecurityGroups[*].{GroupId:GroupId,GroupName:GroupName,VpcId:VpcId,Description:Description}" --output text | \
while read GroupName GroupId VpcId Description; do
    echo "SecurityGroup,$GroupId,Name: $GroupName, Description: $Description" >> $OUTPUT_FILE
done

echo "AWS resources information saved to $OUTPUT_FILE"
