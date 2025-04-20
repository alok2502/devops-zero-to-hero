# Kubernetes Learning Journey 🚀

This README captures my Kubernetes learning experience, especially from a DevOps engineer's perspective — how to manage Kubernetes clusters, understand real-world distributions, and deploy the first application using Minikube and kubectl.

---

## 🔧 Cluster Lifecycle Management in Production

In production, DevOps engineers are responsible for managing the **entire Kubernetes cluster lifecycle**, including:

- ✅ Creation
- 🔄 Upgradation
- ❌ Deletion
- ⚙️ Configuration

---

### 🧪 Local Kubernetes for Development

Tools commonly used for local cluster setups:

- **Minikube**
- **Kind**
- **K3s**

These are typically used for **development or testing**, not for production.

---

## ☁️ Kubernetes Distributions in Production

Kubernetes is open-source, and cloud vendors provide their own managed services (distributions):

| Provider   | Distribution |
|------------|--------------|
| AWS        | EKS          |
| RedHat     | OpenShift    |
| VMware     | Tanzu        |
| Rancher    | Rancher      |
| Microsoft  | AKS          |
| Google     | GKE          |

> These provide enterprise support. If you're using pure Kubernetes on EC2 and face issues, AWS won’t help with Kubernetes — they’ll only support the EC2 level. But with EKS, AWS helps troubleshoot Kubernetes itself.

---

## 💰 Why Pure Kubernetes is Still Used in Prod

- **Cost-efficient**: Managed services like EKS are expensive for large teams.
- **Flexible**: Organizations with less strict SLAs may use pure K8s clusters in production.
- **Staging/Pre-prod**: Great for non-production environments with real-world scale.

---

## 🔧 Tool to Manage Kubernetes at Scale

- **kops**: One of the most widely used tools to manage Kubernetes clusters, especially in production across multiple clusters.

---

# 🚀 Deploying First Application on Kubernetes

## 🐳 Docker vs Kubernetes

- In Docker: We run apps directly using `docker run`
- In Kubernetes: We deploy **pods**, which run containers

---

### 🤔 Why Pod Instead of Container?

Kubernetes **abstracts** container runtime settings using YAML files. A pod is essentially:

- A wrapper around one (or more) containers
- Accepts args like `docker run -p`, volumes, etc., via YAML instead of CLI
- Enables **standardization** and **declarative infrastructure**

---

## 📦 Pod = Container (in most cases)

- Typically, a pod contains one container
- In special cases, pods can contain **multiple containers** (e.g., sidecar, init containers)
- Pods share:
  - **Networking** (localhost communication)
  - **Storage volumes**

---

## 🧰 Commands to Deploy Your First App

### 📥 Install kubectl

```bash
# Download the latest stable version
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl binary
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify installation
kubectl version --client
```

## 🛠 Install Minikube

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
```

### ✅ Start Kubernetes Cluster
```bash
minikube start
kubectl get nodes
```
###### ✅ You should see a node named minikube.

---

```pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
```

#### Equivalent Docker Command
```bash
docker run -d --name nginx -p 80:80 nginx:1.14.2
```

### 🚀 Deploy Pod on Kubernetes
```bash
kubectl create -f pod.yml
kubectl get pods -o wide
```
###### ✅ You will get a Cluster IP — access it using:

```bash
curl <CLUSTER_IP>
(SSH into the Minikube VM first if needed.)
```

### 🔍 Useful kubectl Commands
```bash
kubectl describe pod nginx       # View detailed info
kubectl logs nginx               # Get logs for debugging
kubectl delete pod nginx         # Delete the pod
```
#### 📌 TL;DR
Pods are the lowest deployable unit in Kubernetes

kubectl is the CLI equivalent of Docker CLI

Kubernetes prefers YAML-based declarative configs

Minikube lets us run a lightweight K8s cluster locally

#### ✅ We learned:
How to install & configure kubectl and Minikube

Fix common installation errors

Deploy and test our first pod with NGINX
