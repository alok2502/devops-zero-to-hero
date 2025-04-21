# 🚀 Day 11: Kubernetes – Deployments & Services

This day we understood why Pods are not enough for production workloads and explored how **Deployments** and **Services** play a crucial role in ensuring high availability and reliable access to applications.

---

## 🧱 Why Not Just Pods?

We know:
- In Docker: We run containers via `docker run` with flags for ports, volumes, etc.
- In Kubernetes: Pods wrap containers and accept these specs via YAML.

However, Pods:
- Are **ephemeral** — if they crash or get deleted, they’re gone.
- Don’t **auto-heal** or **auto-scale**.
- Have **dynamic IPs** — which change if a pod is recreated.

So while Pods let us run containers declaratively, they don’t help with high availability or stability.

---

## ⚙️ Enter Deployments

A **Deployment** is a higher-level Kubernetes resource that manages Pods for you.

It works like this:
1. You define the desired state (e.g., 3 replicas of an app).
2. Kubernetes creates a **ReplicaSet**.
3. ReplicaSet ensures that the desired number of Pods are always running.
4. If a Pod crashes or gets deleted, a new one is automatically created.

> You should **never create Pods directly** in production. Always use Deployments to manage them.

### 🧪 Example: NGINX Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

###### Apply it using:

```bash
kubectl apply -f deployment.yaml
```
###### Then try deleting a pod and watch Kubernetes auto-recreate it:
```bash
kubectl delete pod <pod-name>
```

# 🌐 Services in Kubernetes

---

## ❓ Why We Need Services

Imagine your Deployment creates 3 Pods.
If one dies and a new one is created, the new Pod gets a new **IP address**.

Now:

- If a user tries to reach the **old Pod IP**, they can’t access the app.
- IPs are **not stable**, so you can't rely on them for communication.

---

## 🛠️ Enter Services

A **Service** is a **stable network endpoint** for a set of Pods.
It solves three major problems:

### ✅ Load Balancing
Evenly distributes traffic to all available Pods.

### ✅ Service Discovery
Targets Pods based on **labels**, not IPs.
New Pods created with the same label are **auto-detected** by the service.

### ✅ Exposure
Allows access to Pods **from outside the cluster** when needed.

---

## 🎯 Types of Kubernetes Services

| Type         | Access Scope               | Use Case Example                      |
|--------------|----------------------------|---------------------------------------|
| **ClusterIP**    | Internal to cluster only   | Microservice-to-microservice traffic  |
| **NodePort**     | Exposed on Node’s port     | Dev or internal network access        |
| **LoadBalancer** | Public IP via Cloud LB     | Production apps for external users    |

### 🔍 Example Breakdown:
- **LoadBalancer** on AWS creates an **ELB** (Elastic Load Balancer).
- **NodePort** exposes service on a **random port** on each worker node.
- **ClusterIP** is the **default**, only reachable **inside the cluster**.

---

## 💡 Simplified Analogy

Let’s say:
- Your app runs on 3 Pods with **dynamic IPs**.
- You give users a single entry point (Service **IP** or **DNS** name).
- Behind the scenes, the **Service forwards traffic** to live Pods using **kube-proxy**.

> ✅ So, **Services + Deployments = Production-grade setup**

---

## ✅ Summary

- **Pods** are the basic unit but not self-healing or scalable.
- **Deployments** manage **ReplicaSets**, which manage **Pods**.
- **Services**:
  - Make Pods accessible
  - Handle dynamic IP issues
  - Enable load balancing and service discovery

---

## 🧪 What We Practiced

- Created a **Deployment** for NGINX
- Verified **auto-healing** by deleting a Pod
- Learned how a **Service** solves accessibility & IP issues

