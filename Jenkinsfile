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
        stage('Teste da aplicação') {
            steps {
                sh 'chmod +x teste-app.sh'
                sh './teste-app.sh'
            }
        }
    }
}
