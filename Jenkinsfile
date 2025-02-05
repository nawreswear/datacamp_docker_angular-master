pipeline { 
    agent any 
    tools { 
        jdk 'JDK8' 
    }
    environment { 
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64' 
        GIT_HTTP_MAX_REQUEST_BUFFER = '104857600'
        GIT_SSH_COMMAND = 'ssh -o ConnectTimeout=30'
        DOCKER_TAG = getVersion() 
    }
    stages {
        stage ('Clone Stage') {
            steps {
               // git 'https://github.com/nawreswear/datacamp_docker_angular-master.git'
               sh 'git fetch --tags --force --progress --retries=5 https://github.com/nawreswear/datacamp_docker_angular-master.git'


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
                
               	    sh 'sudo docker push nawreswear/aston_villa:${DOCKER_TAG}'
            }
        } 
        stage ('Deploy') {
            steps {
           
                    
                    // Tirer l'image depuis DockerHub
                  //  sh "ssh vagrant@192.168.182.100 'sudo docker pull nawreswear/aston_villa:${DOCKER_TAG}'"
                    
                    // Lancer le container
                   // sh "ssh vagrant@192.168.182.100 'sudo docker run --name aston_villa -d nawreswear/aston_villa:${DOCKER_TAG}'"
	
       			 sh "ssh -o StrictHostKeyChecking=no vagrant@192.168.182.100 'sudo docker pull nawreswear/aston_villa:${DOCKER_TAG}'"
        		sh "ssh -o StrictHostKeyChecking=no vagrant@192.168.182.100 'sudo docker run --name aston_villa -d nawreswear/aston_villa:${DOCKER_TAG}'"
    
                
            }
        }
    }
}

def getVersion() {
    return sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
}








  