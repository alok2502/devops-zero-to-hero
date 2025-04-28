# 🚀 DevOps Journey - Day 9: Introduction to Kubernetes
---

## 🔍 Why Kubernetes?

Before diving into Kubernetes, let’s understand **why** we need it.

### Problems with Docker Alone:
1. **Single Host Limitation** – All containers run on one host. If one container hogs resources, others suffer.
2. **No Auto-Healing** – If a container crashes, there’s no built-in recovery unless done manually.
3. **No Auto-Scaling** – Can’t dynamically scale containers based on traffic/load.
4. **Lacks Enterprise Features** – No built-in load balancing, firewalls, or API gateways.

**Kubernetes** addresses all these issues with ease.

---

## 🤖 Why is it called K8s?

> It’s short for **Kubernetes** — K (first letter) + 8 letters in between + S (last letter) = K8s 😄

---

## 🧱 Core Concepts

### Docker vs Kubernetes

| Docker | Kubernetes |
|--------|------------|
| Simplest unit is **Container** | Simplest unit is **Pod** |
| Uses **Docker Engine / dockershim** | Uses **Kubelet + Container Runtime** |
| Runs on a single node | Runs in a **cluster** with **master and worker nodes** |

---

## ⚙️ Kubernetes Architecture

### 🌐 Control Plane (Master Node)

1. **API Server** – The heart of Kubernetes. Accepts all external requests and acts as the gateway.
2. **Scheduler** – Decides on which node a pod should run based on availability.
3. **Controller Manager** – Handles replicas, node monitoring, auto-scaling, etc.
4. **etcd** – A key-value store that saves the cluster’s current state.
5. **Cloud Controller Manager (CCM)** – Bridges Kubernetes with cloud providers like AWS/GCP.

### 🧱 Worker Node (Data Plane)

1. **Kubelet** – Like Docker engine. Ensures your pods are running and reports to the API Server if they crash (auto-healing).
2. **Container Runtime** – Runs the actual containers (supports Docker, containerd, CRI-O).
3. **Kube Proxy** – Manages network routing, service discovery, and load balancing for pods.

---

## ✅ Features Kubernetes Adds on Top of Docker

- **High Availability**
- **Auto Healing**
- **Horizontal Pod Autoscaling (HPA)**
- **Load Balancing**
- **Enterprise-level Networking and Monitoring**
- **Cloud-Native Compatibility (EKS, AKS, GKE)**

---

## 🎯 Summary

Kubernetes takes containerization to the next level by making your applications resilient, scalable, and cloud-ready.  

---

