# 📘 Day 8: Docker Advanced – Multi-Stage Builds, Distroless Images, Volumes & Networking

---

## 🧱 Multi-Stage Builds

### ✅ Problem with Single-Stage Dockerfiles

- Using `ubuntu` as a base image increases image size drastically.
- Installing unnecessary dependencies (like compilers, package managers, etc.) just to build the app bloats the image.
- All files, build tools, and intermediate layers get included in the final image.

---

### 💡 Solution: Multi-Stage Builds

- A single Dockerfile is split into multiple stages.
- First stage is used only for building the app (compilers, dependencies).
- Second (final) stage is a minimal image that contains only the binary/runtime.
- Helps reduce final image size and attack surface.

---

### 🛠 Example: Golang Calculator App

#### ✅ Single-Stage Dockerfile

```dockerfile
FROM ubuntu AS build
RUN apt-get update && apt-get install -y golang-go
COPY . .
RUN CGO_ENABLED=0 go build -o /app .
ENTRYPOINT ["/app"]
```

###### 📦 Image Size: 861 MB

#### ✅ Multi-Stage Dockerfile with scratch 

```dockerfile
FROM ubuntu AS build
RUN apt-get update && apt-get install -y golang-go
COPY . .
RUN CGO_ENABLED=0 go build -o /app .

FROM scratch
COPY --from=build /app /app
ENTRYPOINT ["/app"]
```
###### 📦 Image Size: 1.83 MB


### 🥷 Distroless Images
Minimal images with only the runtime environment.

No bash, curl, wget, or package managers.

More secure and less prone to vulnerabilities.

Ideal for production containers.

Great for languages like Go where you build static binaries.

### 📦 Docker Volumes & Bind Mounts
#### 🚨 Problem:
Containers are ephemeral.

Important files like logs or shared data between containers are lost if the container crashes.

#### 🔧 Solution:
🔹 Bind Mounts:
Link a host directory to a container directory.

Useful for debugging and sharing files in development.

Limited to host filesystem.

```bash
docker run -v /host/path:/container/path ...
```
🔹 Volumes:
Managed by Docker.

Can be shared across containers.

Persistent storage even if the container dies.

Not tied to host folder structure.

```bash
docker volume create myvol
docker run -v myvol:/data ...
docker volume inspect myvol
docker volume rm myvol
```
### ⚙️ Syntax Difference
-v: Short syntax

--mount: Long, explicit syntax with more control

### 🌐 Docker Networking
#### 🤝 Scenario 1: Containers Need to Talk to Each Other
#### ✅ Bridge Network (default):
Docker creates a docker0 virtual interface.

Containers connected to it can talk to each other and the host.

#### ✅ Custom Bridge Network:
Create isolated logical networks.

Containers on one custom bridge can talk; others cannot.

#### 🔒 Scenario 2: Isolated Containers
Use custom networks to isolate sensitive containers.

Use cases: Payment service, login service, etc.

```bash
docker network create secure-network
docker run --network secure-network ...
```
#### ⚠️ Host Network
Container shares host's network stack.

Offers no network isolation (used for special use cases).

Security risk in most cases.

### 🔥 Project Completed Today
#### 🧮 Project 1: Golang Calculator App
Wrote a Go-based calculator CLI app.

Built it using a single-stage Dockerfile first.

Optimized using a multi-stage Dockerfile with scratch.

Reduced image size from 861 MB to 1.83 MB.

