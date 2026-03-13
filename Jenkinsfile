pipeline {
    agent any

    stages {

        stage('Check Terraform Files') {
            steps {
                dir('terraform') {
                    sh 'ls -l'
                }
            }
        }

        stage('Trivy Scan Terraform Code') {
            steps {
                sh '''
                docker run --rm \
                -v /var/jenkins_home/workspace/Devops_Assignment/terraform:/workspace \
                aquasec/trivy:latest config /workspace \
                --exit-code 1 \
                --severity HIGH,CRITICAL
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                docker run --rm \
                -v /var/jenkins_home/workspace/Devops_Assignment/terraform:/workspace \
                -w /workspace \
                hashicorp/terraform:latest init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                docker run --rm \
                -v /var/jenkins_home/workspace/Devops_Assignment/terraform:/workspace \
                -w /workspace \
                hashicorp/terraform:latest plan \
                -var-file=terraform.tfvars
                '''
            }
        }

    }
}