pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/user/repo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build & Push') {
            steps {
                sh '''
                    docker build -t myapp:latest .
                    docker tag myapp:latest myregistry/myapp:latest
                    docker push myregistry/myapp:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl rollout status deployment/myapp
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}


🔍 How to explain this in the interview (short & perfect)
1. agent any
Tells Jenkins to run the pipeline on any available agent/node.
2. Checkout Stage
Fetches the code from GitHub.
3. Build Stage
Runs mvn clean package to compile and build the application.
4. Test Stage
Runs unit tests using Maven.
5. Docker Build & Push Stage
Builds the Docker image
Tags it
Pushes to container registry (DockerHub/ECR/GCR)
6. Deploy to Kubernetes Stage
Applies the updated deployment YAML
Waits for rollout to finish
Ensures zero-downtime deployment
7. post section
Runs after the pipeline:
success → logs success message
failure → logs failure message