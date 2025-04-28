# Day 6: CI/CD with Jenkins and Docker

## 🌐 What I Learned Today

### 🚀 CI/CD Overview
CI/CD is a two-step process:

- **CI (Continuous Integration):** Automating the steps developers follow before delivering code, such as testing, linting, etc.
- **CD (Continuous Delivery/Deployment):** Automatically deploying the code to platforms where customers can access it.

CI/CD ensures that applications are delivered **efficiently**, **reliably**, and **consistently**—no matter where your customers are in the world.

---

### 📌 Practical Example

1. A developer commits code to GitHub.
2. Jenkins (a CI/CD tool) watches for changes in that GitHub repo.
3. On detecting a change, Jenkins triggers a pipeline:
    - **Unit Testing:** Verifies output for given input.
    - **Static Code Analysis:** Checks for unused variables, indentation, etc.
    - **Security Testing (e.g., SonarQube):** Detects vulnerabilities.
    - **Automation Testing:** Ensures new code doesn't break existing features.
    - **Reports:** Summary of test cases passed/failed.
    - **Deployment:** Pushes the app to environments (dev → stage → prod).

---

### 🛠️ Jenkins Setup on AWS EC2

1. **Launched EC2 Instance (Ubuntu)**
2. **Installed Java:**
   ```bash
   sudo apt update
   sudo apt install openjdk-11-jre
   java -version
    ```
3. Installed Jenkins:
    ```bash
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    sudo apt-get update
    sudo apt-get install jenkins
```
---
4. Allowed Inbound Traffic on Port 8080 (via EC2 security group)

5. Accessed Jenkins UI:

   Retrieved password from:

    ```bash
    /var/lib/jenkins/secrets/initialAdminPassword
    ```
    Installed suggested plugins.

---
## 🐳 Jenkins with Docker as Agent

Installed Docker:

```bash
sudo apt install docker.io -y
```
Granted Docker Permissions:

```bash
sudo su -
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker
```
Verified Docker Installation:

```bash
docker run hello-world
```
Installed Docker Pipeline Plugin in Jenkins:

Manage Jenkins → Plugins → Docker Pipeline → Install & Restart

Created Jenkinsfile for 2-Tier Application

Observed Docker containers being created and destroyed efficiently during the pipeline run.

## ✅ Key Takeaways
Jenkins can automate the entire CI/CD process.

Docker can be used as an agent to run lightweight and scalable builds.

Running Jenkins pipelines in containers saves resources and cost.

CI/CD kicks in automatically on code changes (via GitHub or GitLab).

Jenkins is a legacy tool but still powerful. Alternatives include GitHub Actions and GitLab CI/CD.




