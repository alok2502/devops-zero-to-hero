# 🧭 Kubernetes Ingress — Complete Practical + Deep Dive

## 📌 Why Ingress Was Introduced

Kubernetes **Services** solved 3 major problems:

1. **Exposing apps**: using `NodePort` and `LoadBalancer` to make apps accessible outside the cluster.
2. **Dynamic Service Discovery**: since pods get recreated with new IPs, `Service` uses labels and selectors to dynamically track backend pods.
3. **Basic Load Balancing**: traffic gets equally distributed among pods (round-robin).

However, **enterprise users faced real-world limitations**:
- They were using **advanced load balancers** (like NGINX) that offered features such as:
  - Host/path-based routing
  - Sticky sessions
  - IP whitelisting/blacklisting
  - Rate limiting
- In Kubernetes, to expose 100 services using `LoadBalancer` mode, you'd need **100 public static IPs**, which was **costly** and **inefficient**.

> 🧠 **Hence, Ingress was introduced to solve these problems** — giving us all the above features via a single public IP!

---

## 🚀 How to Deploy Ingress Controller in Minikube

```bash
minikube addons enable ingress
```

### 🔧 Practical Setup (Flask App Example)
##### 1️⃣ flask-app-deployment.yml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
  labels:
    app: flask-app
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
        ports:
        - containerPort: 80
```

##### 2️⃣ service.yml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: flask-app
spec:
  type: NodePort
  selector:
    app: flask-app
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30007
```

##### 3️⃣ ingress.yml
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: flask-app-ingress
spec:
  rules:
  - host: "foo.bar.com"
    http:
      paths:
      - pathType: Prefix
        path: "/bar"
        backend:
          service:
            name: flask-app
            port:
              number: 80
```

# 🛡️ Kubernetes RBAC – Users & Service Accounts

## 🔍 What is RBAC?
RBAC (**Role-Based Access Control**) controls **who can do what** in a Kubernetes cluster. It ensures users and processes only have permissions **based on their roles**, preventing unauthorized modifications.

RBAC in Kubernetes is **divided into two main components**:
1. **Users** – Human operators needing access control.
2. **Service Accounts** – Automated processes requiring specific permissions.

---

## 👤 RBAC: Users in Kubernetes

### 📌 Why User-Based RBAC is Needed
- In **Minikube**, we have **admin access** by default, meaning we can do anything.
- But in a **real-world organization**, unrestricted access can cause problems:
  - A **QA team** with write access could **accidentally modify etcd** or other critical cluster configurations.
  - A **DevOps engineer** or **Kubernetes admin** must enforce **proper access control** to prevent unintended changes.

🚀 **RBAC allows organizations to assign roles based on responsibilities, ensuring security and stability.**

### 🏗️ How RBAC Solves This
Instead of giving **everyone full access**, Kubernetes enforces restrictions through:
- **Roles** – Define **what** actions a user can take.
- **RoleBindings** – Assign **who** gets those permissions.

---

## 🔐 RBAC: Service Accounts in Kubernetes

### 📌 Why Service Accounts?
Not all operations are performed by humans—**applications, CI/CD pipelines, and monitoring tools** often need **automated access**.

- **Service Accounts** allow processes to interact with the cluster **securely**.
- Instead of using **user credentials**, **Kubernetes-managed Service Accounts** ensure proper access restrictions.

🚀 **Ideal for:**
✔️ **CI/CD pipelines** (automated deployments, updates)
✔️ **Monitoring tools** (log collectors, metrics scrapers)
✔️ **In-cluster automation** (self-healing mechanisms, scaling tasks)

---

## 🔍 Summary

| Concept        | Users                                | Service Accounts                       |
|---------------|--------------------------------------|--------------------------------------|
| **Purpose**   | Restricts human users               | Controls automation tasks              |
| **Use Case**  | QA teams, DevOps engineers, admins | CI/CD pipelines, monitoring tools     |
| **Defined By**| `Role`, `ClusterRole`, `RoleBinding` | `ServiceAccount`, `RoleBinding`       |
| **Scope**     | Namespace or cluster-wide           | Namespace or cluster-wide             |

🚀 **RBAC ensures Kubernetes is secure, restricting who can access and modify resources efficiently

---

