#!/bin/bash

# Define CSV file path
OUTPUT_FILE="aws_security_groups_info.csv"

# Add headers to CSV file
echo "Region,Availability Zone,VPC IDs and Names,Security Group Name,Inbound Rules (Ports),Outbound Rules (Ports)" > $OUTPUT_FILE

# Get all AWS regions
regions=$(aws ec2 describe-regions --query "Regions[*].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "Processing region: $region"
    # Set the region for subsequent AWS CLI commands
    aws configure set region $region

    # Get all VPCs with their associated Availability Zones
    aws ec2 describe-vpcs --query "Vpcs[*].{VpcId:VpcId,Tags:Tags[?Key=='Name'].Value | [0]}" --output text | \
    while read VpcName VpcId; do
        VpcName=${VpcName:-"N/A"}  # Handle cases where VPC has no name tag

        # Get availability zones for this VPC
        AvailabilityZones=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$VpcId --query "Subnets[*].AvailabilityZone" --output text)

        # Get security groups for this VPC
        SecurityGroups=$(aws ec2 describe-security-groups --filters Name=vpc-id,Values=$VpcId --query "SecurityGroups[*].{GroupId:GroupId,GroupName:GroupName}" --output text)

        if [ -n "$SecurityGroups" ]; then
            # Loop through each availability zone
            for AvailabilityZone in $AvailabilityZones; do
                # Loop through each security group
                while read -r GroupId GroupName; do
                    # Get inbound rules
                    InboundRules=$(aws ec2 describe-security-groups --group-ids $GroupId --query "SecurityGroups[*].IpPermissions[*].{FromPort:FromPort,ToPort:ToPort,IpProtocol:IpProtocol,IpRanges:IpRanges}" --output text)
                    # Get outbound rules
                    OutboundRules=$(aws ec2 describe-security-groups --group-ids $GroupId --query "SecurityGroups[*].IpPermissionsEgress[*].{FromPort:FromPort,ToPort:ToPort,IpProtocol:IpProtocol,IpRanges:IpRanges}" --output text)

                    # Format Inbound and Outbound rules with port numbers
                    InboundFormatted=""
                    OutboundFormatted=""
                    
                    while read -r FromPort ToPort IpProtocol IpRanges; do
                        if [ -n "$IpProtocol" ]; then
                            if [[ $FromPort == $ToPort ]]; then
                                InboundFormatted+="Protocol: $IpProtocol, Port: $FromPort, CIDR: ${IpRanges:-N/A}\n"
                            else
                                InboundFormatted+="Protocol: $IpProtocol, Port: $FromPort-$ToPort, CIDR: ${IpRanges:-N/A}\n"
                            fi
                        fi
                    done <<< "$InboundRules"

                    while read -r FromPort ToPort IpProtocol IpRanges; do
                        if [ -n "$IpProtocol" ]; then
                            if [[ $FromPort == $ToPort ]]; then
                                OutboundFormatted+="Protocol: $IpProtocol, Port: $FromPort, CIDR: ${IpRanges:-N/A}\n"
                            else
                                OutboundFormatted+="Protocol: $IpProtocol, Port: $FromPort-$ToPort, CIDR: ${IpRanges:-N/A}\n"
                            fi
                        fi
                    done <<< "$OutboundRules"

                    # Append to CSV, formatting as necessary
                    echo "$region,$AvailabilityZone,$VpcName ($VpcId),$GroupName ($GroupId),\"$(echo -e "$InboundFormatted")\",\"$(echo -e "$OutboundFormatted")\"" >> $OUTPUT_FILE
                done <<< "$SecurityGroups"
            done
        fi
    done
done

echo "AWS Security Groups information saved to $OUTPUT_FILE"
