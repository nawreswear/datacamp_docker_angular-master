pipeline {
    agent any
    tools {
        jdk 'Openjdk17' // Using JDK 17
    }

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        DOCKER_TAG = "" // Initialize variable to avoid errors
    }

    stages {
        stage('Initialisation') {
            steps {
                script {
                    DOCKER_TAG = getVersion()
                }
            }
        }

        stage('Nettoyage') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Stage') {
            steps {
                script {
                   git 'https://gitlab.com/jmlhmd/datacamp_docker_angular.git'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t nawreswear/aston_villa:${DOCKER_TAG} .'
            }
        }

        stage('DockerHub Push') {
            steps {
                sh 'docker login -u nawreswear --password zoo23821014'
                sh 'docker push nawreswear/aston_villa:${DOCKER_TAG}'
            }
        }

        stage('Déploiement') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no vagrant@192.168.182.100 'docker pull nawreswear/aston_villa:${DOCKER_TAG}'
                ssh -o StrictHostKeyChecking=no vagrant@192.168.182.100 'docker run --name aston_villa -d nawreswear/aston_villa:${DOCKER_TAG}'
                """
            }
        }
    }
}

def getVersion() {
    return sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
}
