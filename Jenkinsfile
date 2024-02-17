pipeline {
    agent any
    
    stages {
        stage('Build da imagem docker') {
            steps {
                script {
                    // Utilize um nome de imagem mais específico e inclua a tag
                    docker.build('devops/app:latest')
                }
            }
        }
        
        stage('Subir docker compose - redis e app') {
            steps {
                // Execute o docker-compose usando sh e forneça o caminho para o arquivo docker-compose.yml
                sh 'docker-compose -f /caminho/para/docker-compose.yml up --build -d'
            }
        }
        
        stage('Aguardar subida de containers') {
            steps {
                // Aguarde um tempo adequado para que os containers subam
                script {
                    sleep time: 10, unit: 'SECONDS'
                }
            }
        }
        
        stage('Teste da aplicação') {
            steps {
                // Execute o script de teste da aplicação
                sh 'teste-app.sh'
            }
        }
    }
}
