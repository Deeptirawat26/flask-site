pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Install Python dependencies
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Deploy') {
            steps {
                // Execute the deployment script
                sh './deploy_script.sh'
            }
        }
    }
    post {
        always {
            // Archive any build artifacts if needed (e.g., logs)
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
