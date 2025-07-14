pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nikile23/flask-app"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Nikile2003/devops-project1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    script {
                        docker.build("${DOCKER_IMAGE}:latest")
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                    script {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Provision Infrastructure (Terraform)') {
            steps {
                dir('terraform') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                dir('ansible') {
                    sshagent(['ec2-ssh-key']) {
                        sh 'ansible-playbook -i inventory playbook.yml'
                    }
                }
            }
        }
    }
}
