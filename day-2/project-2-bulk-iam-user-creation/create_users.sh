#!/bin/bash

# Script to create IAM users in bulk
# Author: Alok
# Date: 3rd April 2025

USER_FILE="users.txt"

if [ ! -f "$USER_FILE" ]; then
  echo "User file $USER_FILE not found!"
  exit 1
fi

while read -r username; do
  if [[ -n "$username" ]]; then
    echo "Creating user: $username"

    # Create IAM user
    aws iam create-user --user-name "$username"

    # Create login profile
    aws iam create-login-profile --user-name "$username" --password "Welcome@123" --password-reset-required

    # Attach policy
    aws iam attach-user-policy \
      --user-name "$username" \
      --policy-arn "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"

    echo "User $username created and policy attached."
    echo "-------------------------------------------"
  fi
done < "$USER_FILE"

