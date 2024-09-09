## END TO END DEVOPS PROJECT

#### Step-1: Automate Provisioning
Creating a virtual machine server on Azure using Terraform (Infrastructure as Code). Terraform can also be used for many cloud providers such as AWS, Google Cloud Platform, etc. It helps you manage resources directly from your local computer.
1. Install Terraform on your local machine: Terraform Installation
2. Azure CLI installed for authentication: Azure CLI Installation
3. Azure Subscription: You need an active subscription on Azure (you can use free trial also, like mime)
4. Set up Terraform for Azure: Ensure you have proper permissions on Azure.
5. Create terraform configuration file then apply
#### Step-2: Automate Configuring And Server Management
Ansible is an open-source automation tool used for configuration management, application deployment, orchestration, and infrastructure as code. It allows you to automate IT tasks across servers, networks, and cloud environments without the need for manual intervention. Ansible works by connecting to your nodes (servers or devices) over SSH (or WinRM for Windows) to execute tasks using playbooks written in YAML
1. Install Ansible
2. Set Up Inventory File
3. Set Up SSH Access
4. Test the Setup
5. Create an Ansible Playbook
6. Run Playbook

task that I automate:
- Disable Password login
- Install docker on targeted vm/node
- Install monitoring tools {grafana, prometheus} on top docker
- Install Jenkins on top docker
- Setup Loadbalancer and reverse proxy using nginx
- Setup for automatic ssl renewal
#### Step-3: Build, Run And Optimize Docker Image
Docker is an open-source platform that automates the deployment of applications inside lightweight, portable containers. These containers package everything an application needs to run, including the code, runtime, libraries, and system tools, ensuring consistency across different environments (e.g., development, testing, and production).
- Install Docker
- Create Docker image with Dockerfile
  - Create lightweight and distroless image
- Tag and push image to Dockerhub/private regitry (in this case I push to Dockerhub)

Docker Compose is a tool used to define and manage multi-container Docker applications. It allows you to define multiple services (containers) that make up your application in a single YAML file, called docker-compose.yml, making it easier to set up
#### Step-4: Server And Service monitoring
Grafana is an open-source platform used for monitoring and observability. It provides powerful and flexible visualization capabilities for time-series data from various sources. Grafana is widely used to create dashboards that display metrics, logs, and other data in a visually appealing and insightful manner.

Key Features:
- Interactive Dashboards: Create customizable dashboards with various types of visualizations, including graphs, charts, and tables.
- Data Source Integration: Supports a wide range of data sources, including Prometheus, Elasticsearch, InfluxDB, MySQL, and more.
- Alerts: Configure alerts to notify you when specific conditions are met or thresholds are breached.
- User Management: Manage user access and permissions to dashboards and data sources.

Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability. It is particularly well-suited for monitoring cloud-native and containerized applications. Prometheus collects metrics from configured targets at specified intervals and stores them in a time-series database.

Key Features:
- Time-Series Data Storage: Stores metrics as time-series data, allowing for efficient querying and analysis.
- Powerful Query Language (PromQL): Provides a flexible query language to extract and manipulate metrics.
- Scraping and Exporting: Pulls metrics from endpoints exposed by various services (exporters) and stores them in its database.
- Alerting: Integrated alerting system that can send notifications based on specified rules and conditions.

Node Exporter is a Prometheus exporter that exposes system-level metrics about the host machine's hardware and operating system. It provides detailed metrics on CPU usage, memory usage, disk I/O, and network statistics, which can be scraped by Prometheus.

Key Features:
- System Metrics: Collects and exposes metrics related to system performance and resource usage.
- Easy Integration: Works seamlessly with Prometheus to provide a comprehensive view of system health and performance.
- Customizable Metrics: Provides a range of metrics that can be customized to suit specific monitoring needs.

How They Work Together:
1. Prometheus scrapes metrics from various endpoints, including those exposed by Node Exporter.
2. Grafana visualizes the metrics collected by Prometheus, allowing users to create dashboards and view performance data.
3. Node Exporter provides detailed system metrics that Prometheus uses to monitor the health and performance of the underlying infrastructure.

This combination of Grafana, Prometheus, and Node Exporter provides a powerful solution for monitoring and observability, giving you detailed insights into your applications and infrastructure.
#### Step-5: Kubernetes
Here it is the fun part of DevOps... **Kubernetes** or **K8S**. 

Kubernetes (often abbreviated as K8s) is an open-source container orchestration platform designed to automate the deployment, scaling, and management of containerized applications. It was originally developed by Google and is now maintained by the Cloud Native Computing Foundation (CNCF).

Use Cases:
- Microservices Architecture: Kubernetes is well-suited for managing microservices applications due to its scalability and orchestration capabilities.
- Continuous Integration and Continuous Deployment (CI/CD): Kubernetes integrates well with CI/CD pipelines, automating application deployment and updates.
- Cloud-Native Applications: Ideal for applications designed to run in cloud environments, leveraging Kubernetes' scalability and high availability features.

Kubernetes is widely adopted in modern cloud environments due to its ability to handle complex containerized applications with ease and efficiency.

_Kubernetes Setup and Installation coming soon..._
#### Step-6: Install ArgoCD
_ArgoCD Setup and Installation coming soon..._
### Last But Not Least:
#### End-To-End CI\CD Pipeline Implementation
_CI/CD Updated soon..._
