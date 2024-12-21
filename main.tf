provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-s3-bucket"
}

resource "aws_secretsmanager_secret" "my_rds_secret" {
  name = "my-rds-secret"
}

resource "aws_secretsmanager_secret_version" "my_rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_rds_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "password"
  })
}

resource "aws_db_instance" "my_rds" {
  identifier        = "my-rds-instance"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  username          = "admin"
  password          = "password"
  allocated_storage = 20
  db_name           = "my_database"
}

resource "aws_glue_catalog_database" "my_glue_database" {
  name = "my-glue-database"
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repository"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "s3-to-rds-glue-lambda"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.my_ecr_repo.repository_url}:latest"
  role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambda-execution-role"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "rds_instance_id" {
  value = aws_db_instance.my_rds.id
}

output "glue_database_name" {
  value = aws_glue_catalog_database.my_glue_database.name
}

output "rds_secret_arn" {
  value = aws_secretsmanager_secret.my_rds_secret.arn
}

output "ecr_repo_url" {
  value = aws_ecr_repository.my_ecr_repo.repository_url
}
