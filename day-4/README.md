# 🗓️ Day 4 – Configuration Management & Ansible

## 📌 What is Configuration Management?

Configuration management is a process used by DevOps engineers to maintain consistency of system configurations across servers. It becomes essential when managing large-scale infrastructure (e.g., 100s or 1000s of servers).

### 🧑‍💻 Scenario:
- 100 on-prem servers (Ubuntu, CentOS, Windows).
- Installing packages (like Git or DB) manually via SSH is not scalable.
- Shell scripts are OS-specific – a hassle to maintain.

Hence, configuration management tools like **Ansible, Puppet, Chef, Salt** were developed.

---

## 🔧 Why Ansible?

| Feature             | Ansible          | Puppet               |
|---------------------|------------------|----------------------|
| Model               | Push             | Pull                 |
| Agent Requirement   | Agentless        | Requires agent       |
| Architecture        | No master needed | Master-slave         |
| Language            | YAML             | Puppet DSL           |
| Platform Support    | Linux & Windows  | Limited Windows      |
| Protocol Used       | SSH (Linux), WinRM (Windows) | Same or custom |

### ✅ Pros of Ansible:
- Simple YAML syntax.
- Written in Python – easy to extend modules.
- Strong Linux support.
- No agent installation (reduces setup & maintenance).

### ❌ Limitations:
- Weaker support for Windows.
- Debugging is not intuitive.
- Performance issues on managing 10,000+ servers simultaneously.

---

## 🛠️ How It Works:

- **Linux Communication**: via **SSH**.
- **Windows Communication**: via **WinRM**.
- Modules can be reused or shared through **Ansible Galaxy**.

---

## 🚀 Hands-On Setup

### 💻 Ansible & EC2 Setup

1. Launched an EC2 instance: **ansible-machine**.
2. Installed Ansible:
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install ansible -y
   ```
3. Created a second EC2 instance: **target-server**.
4. Verified both instances are in the same VPC.

---

### 🔐 Passwordless SSH Authentication

1. On `ansible-machine`, generated an SSH key:
   ```bash
   ssh-keygen
   ```
2. Copied the public key to `target-server`:
   ```bash
   ssh-copy-id ubuntu@<target-server-private-ip>
   ```
3. Alternatively, manually pasted the public key into:
   ```
   /home/ubuntu/.ssh/authorized_keys
   ```
4. Verified passwordless SSH by connecting:
   ```bash
   ssh ubuntu@<target-server-private-ip>
   ```

---

### ⚡ Ansible Ad-Hoc Commands

1. Created an `inventory` file with the target server’s private IP:
   ```
   10.0.0.10
   ```
2. Ran a simple command to create a file:
   ```bash
   ansible -i inventory all -m shell -a "touch devops.txt"
   ```
3. Verified file creation on target server.

---

### 🧑‍🤝‍🧑 Grouping Hosts in Inventory

Example inventory file:
```ini
[webservers]
10.0.0.10

[dbservers]
10.0.0.20
```

Run command on a specific group:
```bash
ansible -i inventory webservers -m shell -a "mkdir /tmp/web"
```

---

### 📝 First Ansible Playbook

Task: Install and start Nginx on the target server.

`first-playbook.yml`:
```yaml
---
- name: Install and Start nginx
  hosts: all
  become: true

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Start nginx
      service:
        name: nginx
        state: started
```

Run the playbook:
```bash
ansible-playbook -i inventory first-playbook.yml
```

✅ Verified that nginx is running on the target server.

---

### 📦 Ansible Roles

- Useful for large, complex setups (e.g., Kubernetes installation).
- Roles help organize playbooks and improve reusability.

Install a role from Ansible Galaxy:
```bash
ansible-galaxy install <role_name>
```

