pipeline {
    agent any
    
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/sabirrafiq/reactjs-demo.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sabir_reactjs .'
            }
        }
        
        stage('Push Docker Image to Dev Repo') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
                        sh 'docker tag sabir_reactjs sabirrafiq/devrepo:latest'
                        sh 'docker push sabirrafiq/devrepo:latest'
                    }
                }
            }
        }
        
        stage('Push Docker Image to Prod Repo') {
            when {
                branch 'main'
            }
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
                        sh 'docker tag sabir_reactjs sabirrafiq/prodrepo:latest'
                        sh 'docker push sabirrafiq/prodrepo:latest'
                    }
                }
            }
        }
        
        stage('Deploy to AWS') {
            steps {
                // Add your AWS deployment steps here
            }
        }
        
        stage('Monitoring') {
            steps {
                // Add your monitoring setup steps here
            }
        }
    }
}
