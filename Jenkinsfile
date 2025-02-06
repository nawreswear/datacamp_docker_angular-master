pipeline { 
    agent any 
    tools { 
        jdk 'Openjdk17' 
    }

    environment { 
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64' 
        GIT_SSH_COMMAND = 'ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no'
        DOCKER_TAG = ""  // Déclaration pour éviter les erreurs
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
                
                sh 'git clone --depth 1 git@gitlab.com:jmlhmd/datacamp_docker_angular.git'
               
            
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t nawreswear/aston_villa:${DOCKER_TAG} .'
            }
        } 

        stage('DockerHub Push') {
            steps {
                
                sh ' docker login -u nawreswear --zoo23821014'
                
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
