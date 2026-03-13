pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Roshan21p/DevOps_Assignment.git'

            }
        }

        stage('Check Terraform Files') {
            steps {
                dir('terraform') {
                    sh 'ls -l'
                }
            }
        }

        stage('Trivy Scan Terraform Code') {
            steps {
                dir('terraform') {
                    echo "Running Trivy scan on Terraform code..."

                    sh '''
                    docker run --rm \
                    -v $(pwd):/workspace \
                    aquasec/trivy:latest config /workspace \
                    --exit-code 1 \
                    --severity HIGH,CRITICAL
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    echo "Running Terraform init..."

                    sh '''
                    docker run --rm \
                    -v $(pwd):/workspace \
                    -w /workspace \
                    hashicorp/terraform:latest init -input=false
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    echo "Running Terraform plan..."

                    sh '''
                    docker run --rm \
                    -v $(pwd):/workspace \
                    -w /workspace \
                    hashicorp/terraform:latest plan \
                    -input=false
                    '''
                }
            }
        }

    }
}