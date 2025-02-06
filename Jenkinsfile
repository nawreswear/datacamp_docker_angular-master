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

         stage('Clone') {
            steps {
                sshagent(['github-ssh-key']) {
                    sh 'git config --global http.postBuffer 524288000'
                    sh 'git config --global http.lowSpeedLimit 0'
                    sh 'git config --global http.lowSpeedTime 999999'
                    sh 'git config --global http.postBuffer 524288000'
                    sh 'git config --global http.sslBackend openssl'
                    sh 'git clone --depth 1 git@github.com:nawreswear/datacamp_docker_angular-master.git'
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
