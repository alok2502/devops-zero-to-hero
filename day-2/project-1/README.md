# 🧾 AWS Resource Usage Reporting Script

This project provides a basic shell script to fetch and report AWS resource usage using the AWS CLI.

## 📌 Objective

Automate daily AWS resource reporting for services like:
- EC2 Instances
- S3 Buckets
- Lambda Functions
- IAM Users

## 🔧 Prerequisites

- AWS CLI installed and configured (`aws configure`)
- `jq` installed for parsing JSON responses
- EC2 instance or any Linux server with execution permissions

## 📄 Script Details

The script:
- Lists all S3 buckets
- Describes running EC2 instances
- Lists deployed Lambda functions
- Lists IAM users

## ▶️ Usage

1. SSH into your Linux/EC2 server.
2. Make the script executable:
   ```bash
   chmod +x aws-resource-report.sh
3. Run the script:
    ./aws-resource-report.sh

🗓️ Automation (Optional)
You can schedule it with cron to run daily
