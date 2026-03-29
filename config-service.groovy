pipeline {
    agent any

    environment {
        IMAGE_TAG = "8485012281/config-service:1.0.2"
        K8S_NAMESPACE = "default"
        K8S_DIR = "k8s"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_TAG} ."
            }
        }

        stage('Start Minikube') {
            steps {
                sh "minikube start --profile ${MINIKUBE_PROFILE} --driver=docker || echo 'Minikube already running'"
                sh "eval \$(minikube -p ${MINIKUBE_PROFILE} docker-env)"
            }
        }        

        stage('Deploy Spring Boot App') {
            steps {
                echo "Deploying Spring Boot app to Minikube..."
                dir("${K8S_DIR}") {
                    sh "kubectl apply -f configmap.yaml -n ${K8S_NAMESPACE}"
                    sh "kubectl apply -f secret.yaml -n ${K8S_NAMESPACE}"
                    sh "kubectl apply -f deployment.yaml -n ${K8S_NAMESPACE}"
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Verifying Pods and Services..."
                sh "kubectl get pods -n ${K8S_NAMESPACE}"
                sh "kubectl get svc -n ${K8S_NAMESPACE}"
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Deployment Failed!"
        }
    }
}