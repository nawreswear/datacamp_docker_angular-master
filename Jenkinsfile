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
                git 'https://gitlab.com/jmlhmd/datacamp_docker_angular.git'
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
                
            }
        }
    }
}

def getVersion() {
    return sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
}








  