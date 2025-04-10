📁 Project 3 – GitHub Repository Access Checker
🔧 Description
As a DevOps engineer, managing access to multiple GitHub repositories across different teams is crucial. This script helps list users who have read access to any given GitHub repository. It's especially useful for reviewing access during offboarding or security audits.

🧠 Use Case
When an employee resigns or changes roles, this script can identify if they still have access to any repositories — allowing you to take appropriate action.

📜 Script Functionality
Takes repository owner and repository name as input.

Authenticates with GitHub using a personal access token.

Lists all collaborators with read (pull) access.

🚀 Usage
## Set environment variables username and token:

export username="your-github-username"
export token="your-personal-access-token"

## Run the script:

./list_users.sh <repo_owner> <repo_name>

## Output:

Shows all users with read access.

Informs if no such users exist.

