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
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh '''
                    git config --global http.postBuffer 524288000
                    echo "Vérification de la connexion SSH avec GitHub"
                    ssh -T git@github.com || true
                    echo "Mise à jour du référentiel git"
                    git fetch --all
                    echo "Mesure du temps de clonage"
                    time git clone --depth 1 git@gitlab.com:jmlhmd/datacamp_docker_angular.git
                    '''
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
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_PASSWORD')]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u nawreswear --password-stdin'
                }
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
