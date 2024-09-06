pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    // Trigger AWS CodeDeploy to deploy the application 
                    sh 'aws deploy create-deployment --application-name flask-app --deployment-group-name flask-deploy-group --revision file://appspec.yml'
                }
            }
        }
    }

    post {
        always {
            // Archive any build artifacts if needed like logs
            archiveArtifacts artifacts: '**/build/**', allowEmptyArchive: true
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
