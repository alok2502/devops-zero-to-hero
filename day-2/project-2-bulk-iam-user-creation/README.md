# 📁 Project 2: Bulk IAM User Creation using AWS CLI

This project demonstrates how to create multiple IAM users on AWS in one go using a shell script and the AWS CLI.  
It reads usernames from a file and performs the following actions for each user:
- Creates the IAM user
- Sets a default console password
- Attaches a basic policy (AmazonEC2ReadOnlyAccess)

---

## 🛠️ Prerequisites
- AWS CLI configured on your system
- IAM permissions to create users and attach policies
- Linux or MacOS terminal (or WSL for Windows)

---

## 📄 Files

### `users.txt`
A text file with one username per line.

### `create_users.sh`
Shell script to create users from `users.txt`.

---

## 🚀 How to Run

1. Clone this repo or copy files into your project directory  
2. Make the script executable:
   ```bash
   chmod +x create_users.sh
3. Run the script:
    ./create_users.sh

🔐 Default Password
All users will get the same default password: Welcome@123
(They will be prompted to change it on first login.)


📌 Notes
- You can change the attached policy in the script (AmazonEC2ReadOnlyAccess)

- Add group assignments or email notifications for more advanced usage

- Make sure MFA or password policies are considered for production setups


