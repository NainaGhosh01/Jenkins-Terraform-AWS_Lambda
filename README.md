
# CI/CD Pipeline with Docker, Terraform, AWS, and Python

# Overview

This project sets up a CI/CD pipeline using Jenkins, Docker, Terraform, AWS, and Python. The pipeline automates the process of building a Docker image, deploying it to AWS ECR, and provisioning necessary AWS resources using Terraform. It also involves creating a Lambda function from the Docker image and testing it.




## Prerequisite

- AWS Account with IAM role permissions for creating the necessary resources (S3, RDS, Glue, Lambda, ECR, IAM roles).
- EC2 Instance running Ubuntu (or any preferred Linux OS).
- GitHub to store the code for Python, Docker, Terraform, and Jenkins.
- Jenkins installed and running on your EC2 instance.
## Setup Steps and Use the Pipeline

1. GitHub Repository
  - Create a GitHub repository and push your code to the repository. This includes the Dockerfile, Python application (app.py), and Terraform resources (resources.tf).
  - Example repository URL: https://github.com/NainaGhosh01/Jenkins-Terraform-AWS_Lambda.git
  

2. Manual EC2 Setup for Jenkins, Docker, and Terraform
  - EC2 Instance: Manually launch an EC2 instance in your desired AWS region.
  - Jenkins Installation: Install Jenkins on the EC2 instance and configure it with necessary plugins (Git, Docker, Terraform, etc.).
  - Docker Installation: Install Docker on the EC2 instance to manage containers for building the Docker image.
  - Terraform Installation: Install Terraform to automate the provisioning of AWS resources.

3. Jenkins Pipeline Configuration:
  - Git Plugin: Ensure the Git plugin is installed to clone the repository.
  - Docker Plugin: Install Docker plugin to build Docker images in Jenkins.
  - Terraform Plugin: Install the Terraform plugin to run Terraform commands for provisioning AWS resources.
  - Configure Jenkins Pipeline Job:
      - Create a new Jenkins pipeline job.
      - Set up the GitHub repository URL and branch (e.g., main).
      - Configure Jenkins credentials to access GitHub.
4. Jenkinsfile Setup
- The Jenkinsfile defines the stages of the pipeline: checkout, build Docker image, login to AWS ECR, push Docker image to ECR, run Terraform to provision AWS resources, and test the Lambda function.

5. Dockerfile
- The Dockerfile is used to create a Docker image containing the Python application. This Docker image is later pushed to AWS ECR and used to create a Lambda function.

6. Terraform Configuration
The resources.tf file defines the AWS resources needed for the project, such as:
- AWS ECR repository for storing Docker images.
- Lambda function using the Docker image created in the previous steps.

7. Pipeline Execution
The pipeline automates the following tasks:
- Checkout: Pulls the code from the GitHub repository.
- Build Docker Image: Builds the Docker image using the Dockerfile in the repository.
- Login to AWS ECR: Logs into AWS ECR to push the image.
- Push Docker Image to ECR: Pushes the built image to AWS ECR.
- Run Terraform: Applies the Terraform configuration to provision the required AWS resources (e.g., Lambda, ECR).
- Test Lambda Function: Creates a Lambda function from the Docker image and tests it.

8. Testing and Validation
- After the pipeline is executed, the Lambda function is tested to verify the data flow from S3 to RDS (or Glue, if RDS is unavailable).
## Conclusion

- This setup provides a fully automated pipeline using Jenkins, Docker, Terraform, AWS, and Python. The process automates Docker image building, pushing to AWS ECR, infrastructure provisioning using Terraform, and the testing of a Lambda function, ensuring a robust and repeatable deployment cycle.
