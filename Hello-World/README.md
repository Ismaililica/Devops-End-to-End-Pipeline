📘 Project Overview

This project demonstrates a complete CI/CD (Continuous Integration and Deployment) pipeline using Jenkins, Maven, Docker, and Tomcat, all hosted on AWS EC2 instances.

Whenever new code is pushed to GitHub, Jenkins automatically:

Pulls the latest code from the repository

Builds the project with Maven

Packages a .war file

Transfers it to a remote Docker host

Deploys it into a Tomcat container running on AWS

🧱 Architecture
Developer → GitHub → Jenkins → Maven → Docker (Tomcat Container) → AWS

Components
Layer	Description
GitHub	Source code repository, triggers Jenkins on every push
Jenkins (AWS EC2 #1)	CI/CD automation server that builds and deploys the app
Maven	Handles build, compile, and packaging
Docker (AWS EC2 #2)	Hosts the Tomcat container and runs the web application
Tomcat	Java web application server
AWS EC2	Cloud infrastructure for scalability and remote access
🔄 Pipeline Workflow

1️⃣ Developer pushes code → GitHub repository
2️⃣ Webhook triggers Jenkins automatically
3️⃣ Jenkins pulls code and runs mvn clean install
4️⃣ Maven compiles, tests, and creates webapp.war
5️⃣ Jenkins sends the .war file to the Docker host via SSH
6️⃣ Docker host builds a Tomcat image and deploys the .war
7️⃣ Application is live on AWS EC2 (Tomcat container)

⚙️ Jenkins Configuration
🧩 Source Code Management

Repository: https://github.com/Ismaililica/hello-world.git

🔔 Build Triggers

✅ GitHub hook trigger for GITScm polling

⏱️ (Optional) Poll SCM → H/5 * * * * (every 5 minutes)

🧰 Build Steps
mvn clean install

🚀 Post-Build (Deploy over SSH)
cd /opt/docker
docker stop registerapp || true
docker rm registerapp || true
docker build -t regapp:v1 .
docker run -d --name registerapp -p 8086:8080 regapp:v1

🌍 Deployment & Access

After Jenkins successfully builds and deploys:

Container running:

docker ps


Access application:

http://<EC2-Public-IP>:8080/webapp


Example:

http://13.58.214.111:8080/webapp

🧰 Tech Stack
Tool	Purpose
AWS EC2	Cloud-based servers for Jenkins & Docker
Jenkins	Continuous Integration & Delivery (CI/CD)
Maven	Build automation & dependency management
Docker	Containerized Tomcat deployment
Tomcat	Java web server
GitHub	Version control & webhook integration
📈 Results

✅ Fully automated CI/CD workflow
✅ Distributed build and deployment across AWS servers
✅ Zero manual deployment steps
✅ Reliable rollback using Docker containers
✅ Real-world DevOps setup demonstrating continuous delivery

🧑‍💻 Author

İsmail Ilıca
DevOps & Cloud Enthusiast ☁️
🔗 GitHub Profile

🖼️ Architecture Diagram (Mermaid)
flowchart LR
A[Developer] --> B[GitHub Repo]
B --> C[Jenkins Build Server]
C --> D[Maven Build -> WAR]
D --> E[SSH Transfer]
E --> F[Docker Host]
F --> G[Tomcat Container]
G --> H[Live App on AWS]