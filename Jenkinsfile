pipeline {
    agent any

    environment {
        GCP_PROJECT = 'calculadora-python-466204'  // Cambiar por tu proyecto GCP
        GCR_IMAGE = "gcr.io/${GCP_PROJECT}/calculadora-python:${BUILD_NUMBER}"
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.build("gcr.io/calculadora-python-466204/calculadora-python:10")
                    }    
                }
            }
        }

        stage('Push to GCR') {
            steps {
                script {
                    docker.withRegistry('https://gcr.io', 'gcp-credentials') {
                        docker.image(GCR_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy with Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}