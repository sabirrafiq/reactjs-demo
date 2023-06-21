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
                sshagent(['ssh-key']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.235.68.196 'docker pull sabirrafiq/devrepo:latest'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.235.68.196 'docker stop my-app-container || true'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.235.68.196 'docker rm my-app-container || true'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.235.68.196 'docker run -d -p 80:80 --name my-app-container sabirrafiq/devrepo:latest'"
                }
            }
        }
        
        // stage('Monitoring') {
        //     steps {
        //         // Add your monitoring setup steps here
        //     }
        // }
    }
}
