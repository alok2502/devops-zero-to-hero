# 🗓️ Day 3 – Git, GitHub, Branching & Deploying a Project on EC2

## 📘 Git & GitHub Basics

### ✅ Purpose of Version Control
- Enables collaboration among developers.
- Maintains version history, rollback capability.

### 🔁 Git vs GitHub
- **Git**: Distributed version control system.
- **GitHub**: Web platform built on Git for hosting repositories.

### 🌐 Centralized vs Distributed VCS
- **Centralized (CVS, SVN)**: Relies on a central server. If the server is down, no code collaboration is possible.
- **Distributed (Git)**: Every developer has a complete local copy of the repository, enabling offline work.

---

## 🔧 Common Git Commands

```bash
git init              # Initialize repository
git status            # Show working directory status
git add .             # Stage all files
git diff              # View unstaged changes
git commit -m "msg"   # Commit changes
git log               # View commit history
git log --oneline     # View compact commit log
git reset --hard      # Reset to last commit
git push              # Push commits to remote
```


## 🌱 Branching Strategy
Create feature branches from main.

Avoid committing directly to main.

Use release branches for production-ready deployments.

Use hotfix branches for critical bug fixes.

```bash
git branch feature-name           # Create new branch
git checkout -b feature-name      # Create and switch to new branch from main
```


## 🔀 Merge, Rebase, Cherry-Pick
```bash
-- git merge: Adds all feature branch commits to the end of the main branch.

-- git rebase: Rewrites the base to apply feature branch changes after the point of divergence.

-- git cherry-pick <commit>: Selectively apply one or more specific commits.
```

## 🌿 Clone vs Fork
Clone: Download a repository to your local machine.

Fork: Create a copy of a repository under your GitHub account (used to contribute to other projects).

## 🚀 Deploying a Node.js Project on AWS EC2
🧑‍💻 IAM & EC2 Setup
Created an IAM user with admin access (for learning purposes).

Launched an Ubuntu EC2 instance.

SSH’d into the instance using .pem key.

## 🧰 Environment Setup
```bash
sudo apt update && sudo apt upgrade -y    # Update system
git --version                             # Verify Git
sudo apt install nodejs npm -y           # Install Node.js and npm
```

## 📦 Project Setup
```bash
git clone <repo_url>   # Clone project
cd project-folder
npm install            # Install dependencies
```

## 🌍 Access the Application
Modified EC2 Security Group to allow inbound traffic on required port (e.g., 3000).

Accessed the app via browser:
http://<EC2-Public-IP>:3000

#### 📌 End of Day 3 Notes

