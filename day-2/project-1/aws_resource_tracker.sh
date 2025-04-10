#!/bin/bash

###########################################################
# Author  : Alok
# Date    : 3rd April
# Purpose : AWS Resource Usage Report Script
# Version : v1
###########################################################

# Exit on error
set -e

echo "Fetching AWS resource usage..."

# S3 Buckets
echo -e "\nS3 Buckets:"
aws s3 ls

# EC2 Instances
echo -e "\nEC2 Instances:"
aws ec2 describe-instances \
    --query 'Reservations[].Instances[].{ID:InstanceId,State:State.Name,Type:InstanceType}' \
    --output table

# Lambda Functions
echo -e "\nLambda Functions:"
aws lambda list-functions \
    --query 'Functions[].{Name:FunctionName,Runtime:Runtime}' \
    --output table

# IAM Users
echo -e "\nIAM Users:"
aws iam list-users \
    --query 'Users[].{UserName:UserName,Created:CreateDate}' \
    --output table

echo -e "\nReport complete."



