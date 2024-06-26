pipeline {
    agent any
    stages {
        stage('Build da imagem Docker') {
            steps {
                sh 'docker build -t devops/app .'
            }
        }
        stage('Subir Docker Compose - Redis e App') {
            steps {
                sh 'docker-compose up --build -d'
            }
        }
        stage('Aguardar subida de containers') {
            steps {
                sh 'sleep 10'
            }
        }
        stage('Sonarqube validation') {
            steps {
                script {
                    scannerHome = tool 'sonar-scanner'
                }
                withSonarQubeEnv('sonar-server') {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=redis-app -Dsonar.sources=. -Dsonar.host.url=${env.SONAR_HOST_URL} -Dsonar.login=${env.SONAR_AUTH_TOKEN}"
                }
            }
        }
        stage("Quality Gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
        stage('Teste da aplicação') {
            steps {
                sh 'chmod +x teste-app.sh'
                sh './teste-app.sh'
            }
        }
        stage('Encerrando os containers do teste') {
            steps {
                sh 'docker-compose down'
            }
        }
        stage('Upload docker image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD' )]){
                        sh 'docker login -u $USERNAME -p $PASSWORD ${NEXUS_URL}'
                        sh 'docker tag devops/app:latest ${NEXUS_URL}/devops/app'
                        sh 'docker push ${NEXUS_URL}/devops/app'
                    }
                }
            }
        }
        stage('Apply k8s files') {
            steps {
                sh '/usr/local/bin/kubectl apply -f ./k3s/redis.yaml'
                sh '/usr/local/bin/kubectl apply -f ./k3s/redis-app.yaml'
            }
        }
    }
}
