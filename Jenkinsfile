pipeline {
    agent any

    environment {
        GCP_PROJECT = 'calculadora-python-466204'  // Cambiar por tu proyecto GCP
        GCR_IMAGE = "gcr.io/${GCP_PROJECT}/calculadora-python:${BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(GCR_IMAGE)
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