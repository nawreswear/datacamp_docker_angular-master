<<<<<<< HEAD
pipeline {
    agent any
    tools {
        jdk 'Openjdk17'
    }

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
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
                script {
                    // Charger la clé SSH directement dans l'environnement
                    sh '''
                        mkdir -p ~/.ssh
                        echo "votre_clé_privée_ssh" > ~/.ssh/id_rsa
                        chmod 600 ~/.ssh/id_rsa
                        ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
                    '''
                    // Cloner le dépôt via SSH
                    sh 'git clone git@gitlab.com:jmlhmd/datacamp_docker_angular.git'
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
=======
pipeline { 
    agent any 
    tools { 
        jdk 'JDK8' 
    }
    environment { 
        JAVA_HOME = '/usr/lib/jvm/java-1.8.0-openjdk-amd64' 
        DOCKER_TAG = getVersion() 
    }
    stages {
        stage ('Clone Stage') {
            steps {
                git 'https://github.com/nawreswear/datacamp_docker_angular-master.git'
            }
        }
        stage ('Docker Build') {
            steps {
                sh 'docker build -t nawreswear/aston_villa:${DOCKER_TAG} .'
            }
        } 
        stage ('DockerHub Push') {
            steps {
                
                    sh 'sudo docker login -u nawreswear -p zoo23821014'
                
                sh 'sudo docker push nawreswear/aston_villa::${DOCKER_TAG}'
            }
        } 
        stage ('Deploy') {
            steps {
           
                    
                    // Tirer l'image depuis DockerHub
                    sh "ssh vagrant@192.168.182.100 'sudo docker pull nawreswear/aston_villa:${DOCKER_TAG}'"
                    
                    // Lancer le container
                    sh "ssh vagrant@192.168.182.100 'sudo docker run --name aston_villa -d nawreswear/aston_villa:${DOCKER_TAG}'"
                
>>>>>>> 4bcbf2b2ec2079475e805e7780f6ef4352449aa1
            }
        }
    }
}

def getVersion() {
<<<<<<< HEAD
    return sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
}
=======
    return sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
}








  
>>>>>>> 4bcbf2b2ec2079475e805e7780f6ef4352449aa1
