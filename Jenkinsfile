pipeline {
    agent any

    environment {
        S3_BUCKET_NAME = sh(script: "terraform output -raw s3_bucket_name", returnStdout: true).trim()
        S3_KEY = 'your-data-file-key'
        RDS_INSTANCE_ID = sh(script: "terraform output -raw rds_instance_id", returnStdout: true).trim()
        GLUE_DATABASE_NAME = sh(script: "terraform output -raw glue_database_name", returnStdout: true).trim()
        RDS_SECRET_ARN = sh(script: "terraform output -raw rds_secret_arn", returnStdout: true).trim()
        ECR_REPO_URL = sh(script: "terraform output -raw ecr_repo_url", returnStdout: true).trim()
        LAMBDA_FUNCTION_NAME = "s3-to-rds-glue-lambda"
    }

    stages {
        stage('Checkout Code from GitHub') {
            steps {
                // Checkout the code from GitHub repository
                git url: 'https://github.com/NainaGhosh01/Jenkins-Terraform-AWS_Lambda.git', branch: 'main'
            }
        }

        stage('Deploy Resources') {
            steps {
                // Run Terraform to create AWS resources
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile
                    sh 'docker build -t my-python-image .'
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Authenticate to AWS ECR
                    sh """
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REPO_URL}
                    """
                    // Tag and push the Docker image to ECR
                    sh "docker tag my-python-image:latest ${ECR_REPO_URL}:latest"
                    sh "docker push ${ECR_REPO_URL}:latest"
                }
            }
        }

        stage('Create Lambda Function') {
            steps {
                script {
                    // Create Lambda function from Docker image in ECR
                    sh """
                    aws lambda create-function \
                        --function-name ${LAMBDA_FUNCTION_NAME} \
                        --package-type Image \
                        --image-uri ${ECR_REPO_URL}:latest \
                        --role arn:aws:iam::${AWS_ACCOUNT_ID}:role/lambda-execution-role
                    """
                }
            }
        }

        stage('Invoke Lambda Function') {
            steps {
                script {
                    // Invoke the Lambda function to test it
                    sh """
                    aws lambda invoke \
                        --function-name ${LAMBDA_FUNCTION_NAME} \
                        output.json
                    cat output.json
                    """
                }
            }
        }
    }
}
