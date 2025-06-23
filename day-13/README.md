
# 🚀 Day 13: Extending Kubernetes & Configuration Management

---

## 🔍 Why Extend Kubernetes?

A Kubernetes cluster comes with **native resources** like:
- Deployments, Pods, Services, Ingress (built-in functionality)
- Secrets & ConfigMaps for configuration management

But what if we need something **Kubernetes doesn’t provide out of the box?**

📌 Examples:
- **Istio** → Adds service mesh capabilities  
- **ArgoCD** → Enables GitOps automation  
- **Keycloak** → Integrates authentication  

Kubernetes allows extension through:
1. **Custom Resource Definitions (CRD)**
2. **Custom Resources (CR)** 
3. **Custom Controllers**

---

## 📌 CRD, CR & Custom Controllers Explained

### ✅ 1️⃣ Custom Resource Definition (CRD)
- Defines a **new resource type** in Kubernetes
- Specifies **validation rules & required fields**
- Once defined, users can create **Custom Resources** (CRs)

> 🧠 Think of a CRD as a **blueprint** for a new K8s resource.

---

### ✅ 2️⃣ Custom Resource (CR)
- A **concrete instance** of a CRD
- Like creating a Deployment or Service
- But without a controller, it won’t actually *do* anything

> 🧠 Think of CRs as **objects built from the CRD blueprint**

---

### ✅ 3️⃣ Custom Controller
- Watches for CRs and **performs actions**
- Ensures Kubernetes **reconciles desired state**
- Typically written in **Golang** (with client-go)

> 🧠 Think of a Controller as the **operator** that manages CRs.

---

## 🔐 ConfigMaps & Secrets in Kubernetes

### 💭 Why We Need Them?

Applications often require external config like:
- ✅ DB username
- ✅ DB password
- ✅ DB connection string
- ✅ DB port

Instead of hardcoding configs, use:
- 🔹 **ConfigMap** → Non-sensitive config (e.g., port)
- 🔹 **Secret** → Sensitive config (e.g., password)

---

## 🗄️ ConfigMaps

### ✅ Create a ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: db-connection
data:
  db_port: "3306"
```

Apply it:

```bash
kubectl apply -f cm.yml
```

💡 Why use apply instead of create? ✔ apply updates resources if they exist, whereas create only works for new resources.

### ✅ Use ConfigMap as Environment Variables

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
      - name: flask-container
        image: roronoazoro777/flask-web-app:v1
        env:
          - name: DB_PORT
            valueFrom:
              configMapKeyRef:
                name: db-connection
                key: db_port
```

Apply it:

```bash
kubectl apply -f flask-app-deployment.yml
```

💡 Issue: Changing db_port in the ConfigMap does not auto-update.

### ✅ Use ConfigMap with Volume Mounts (Dynamic Updates)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask-app
  template:
    spec:
      containers:
      - name: flask-container
        image: roronoazoro777/flask-web-app:v1
        volumeMounts:
          - name: db-connection
            mountPath: /opt
      volumes:
        - name: db-connection
          configMap:
            name: db-connection
```

Apply it:

```bash
kubectl apply -f flask-app-deployment.yml
```

Verify:

```bash
kubectl exec -it <pod-name> -- /bin/bash
cd /opt
cat db_port
```

🔥 MAGIC: Changing the ConfigMap instantly updates without restarting the pod! 🚀

---

## 🔐 Secrets in Kubernetes

### ✅ Create a Secret (Base64 Encoding)

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
data:
  username: YWRtaW4=  # base64-encoded 'admin'
  password: cGFzc3dvcmQ=  # base64-encoded 'password'
```

Apply it:

```bash
kubectl apply -f secrets.yml
```

Verify encryption:

```bash
kubectl get secrets db-credentials -o yaml
```

### ✅ Mount Secrets as a Volume

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  template:
    spec:
      containers:
      - name: flask-container
        image: roronoazoro777/flask-web-app:v1
        volumeMounts:
          - name: db-credentials
            mountPath: /opt
      volumes:
        - name: db-credentials
          secret:
            secretName: db-credentials
```

Apply it:

```bash
kubectl apply -f flask-app-deployment.yml
```

Check inside the pod:

```bash
kubectl exec -it <pod-name> -- /bin/bash
ls /opt
cat /opt/username
cat /opt/password
```

Expected Output:

```bash
admin
password
```

🔥 Secrets securely mounted as files! 🚀

---

# 📦 Summary – Kubernetes CRDs, ConfigMaps & Secrets

| **Concept**        | **CRD & CRs**                          | **ConfigMaps**                  | **Secrets**                          |
|--------------------|--------------------------------------|--------------------------------|-------------------------------------|
| **Purpose**       | Define new API resources in Kubernetes | Store non-sensitive config     | Store sensitive config (passwords, keys) |
| **Storage**       | Defined by CRD, stored in cluster    | Plain text in etcd            | Encrypted in etcd                  |
| **Security**      | Managed by controllers              | Not encrypted                 | Encrypted, RBAC restricted         |
| **Access Control** | Controller-defined                  | Accessible to cluster         | Restricted via RBAC                |
| **Usage**        | Extend Kubernetes                    | App configs                   | Credentials, API keys              |

