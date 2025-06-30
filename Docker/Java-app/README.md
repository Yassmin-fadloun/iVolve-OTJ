# Java Spring Boot in Docker

## Objective
Run a Java Spring Boot application in a Docker container using two different methods:
- Multi-stage Docker build
- Single-stage Docker build

## Setup
- Application Source: https://github.com/lbrahim-Adel15/Docker-1
- Output JAR: `target/demo-0.0.1-SNAPSHOT.jar`
- Base image: Maven with Java 17
- Exposed port: 8080

---

## Part 1: Multi-Stage Docker Build

### Steps

1. Clone the app source:
```bash
git clone https://github.com/lbrahim-Adel15/Docker-1.git
cd Docker-1
```

2. Create [Dockerfile.multi](Dockerfile.multi) 

3. Build the Docker image:
```bash
docker build -f Dockerfile.multi -t springboot-multi .
```
4. Run the container:
```bash
docker run -d -p 8080:8080 --name springboot-multi-app springboot-multi
```
5. Test:
```bash
curl http://localhost:8080
```
## Part 2: Single-Stage Docker Build (Build Outside Docker)

### Steps
