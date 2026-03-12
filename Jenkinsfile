pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Roshan21p/DevOps_Assignment.git'
            }
        }

        stage('Infrastructure Security Scan') {
            steps {
                dir('terraform') {
                    echo 'Running Trivy scan on Terraform files...'
                    sh 'trivy config . --severity CRITICAL,HIGH'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('terraform') {
                        sh 'terraform init -input=false'
                        sh 'terraform plan -input=false -refresh=false'
                    }
                }
            }
        }
    }
}