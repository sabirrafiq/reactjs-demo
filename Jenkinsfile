pipeline {
    agent any
    
    stages {
        stage('Clone Repository') {
            steps {
                script {
                    env.each { key, value ->
                        echo "test ${key} = ${value}"
                    }
                    if (env.BRANCH_NAME == 'dev') {
                        git branch: 'dev', url: 'https://github.com/sabirrafiq/reactjs-demo.git'
                    } else if (env.BRANCH_NAME == 'master') {
                        git branch: 'master', url: 'https://github.com/sabirrafiq/reactjs-demo.git'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }
                }
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
                branch 'master'
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
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.108.54.61 'docker pull sabirrafiq/devrepo:latest'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.108.54.61 'docker stop my-app-container || true'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.108.54.61 'docker rm my-app-container || true'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.108.54.61 'docker run -d -p 80:80 --name my-app-container sabirrafiq/devrepo:latest'"
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
