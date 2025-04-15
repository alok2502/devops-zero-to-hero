# 🐳 Day 7: Containerization with Docker

Today we explored the basics of containers, how they compare with virtual machines, and why Docker has become a leading platform for containerization.

---

## 📚 Theory Recap

### Why Containers?
- Virtual machines solve resource utilization issues of physical machines.
- But VMs are still heavy because each VM includes a full OS.
- Containers are lightweight and fast — they package application + libraries + dependencies but **share the host OS kernel**.

### Container Models:
1. Containers on top of **physical servers**.
2. Containers on top of **virtual machines**.

### Why Containers are Lightweight:
- VMs = full OS, use hypervisors.
- Containers = base OS + only app-related dependencies.
- Shared libraries, system calls, namespaces come from the host OS.
- Example: EC2 snapshot is ~2GB, container snapshot is just MBs!

### Security Comparison:
- VMs are more isolated due to separate OS.
- Containers share the kernel — this could lead to risk if one container is compromised.

### Key Directories in Containers:
- `/bin`, `/sbin`, `/etc`, `/lib`, `/usr`, `/var`, `/root`

### What Containers Share with Host:
- Host filesystem
- Networking stack
- System calls
- Control groups
- Namespaces

### What is Docker?
- Docker is a platform to implement containerization.
- It consists of:
  - `dockerd`: Docker daemon
  - `docker CLI`: Docker client that sends instructions

### Docker Architecture:
- User runs commands like `docker build`, `docker run`.
- Docker engine builds image and runs it as container.

### Docker Lifecycle:
1. Write a `Dockerfile`
2. `docker build` → creates Docker image
3. `docker run` → launches container from the image

### Docker Registry:
- Like GitHub for code, Docker Hub is for images.
- Public or private repositories for sharing container images.

### Real-World Use Case:
Without Docker:
- Launch EC2 → Install Python → Pip dependencies → Run app

With Docker:
- Just run the container image — everything’s pre-configured!

---

# 🐳 Day 7: Containerization with Docker

This repo contains the work done on Day 7 of the DevOps journey. It includes two basic Docker projects: one with a Python script and another with a Java program.

---

## 🐍 Project 1: Python App

**Structure**
```
python-app/
├── Dockerfile
└── app.py
```

**app.py**
```python
print("Hello World")
```

**Dockerfile**
```dockerfile
FROM ubuntu:latest
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y python3 python3-pip
CMD ["python3", "app.py"]
```

---

## ☕ Project 2: Java App

**Structure**
```
java-app/
├── Dockerfile
└── src/
    └── Main.java
```

**Main.java**
```java
import java.util.Date;

public class Main {
    public static void main(String[] args) {
        Date currentDate = new Date();
        System.out.println("Hello, Docker! Current date: " + currentDate);
    }
}
```

**Dockerfile**
```dockerfile
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY src/Main.java Main.java
RUN javac Main.java
CMD ["java", "Main"]
```

---

## ✅ Steps Performed Today

- Learned container basics, difference from VMs
- Installed Docker on EC2 and resolved permission issue
- Created Docker images for Python and Java apps
- Pushed Python image to Docker Hub: [`roronoazoro777/my-first-docker-image`](https://hub.docker.com/r/roronoazoro777/my-first-docker-image)
- Practiced modifying source code and rebuilding containers

---

You're all set for more container magic! 🚀

