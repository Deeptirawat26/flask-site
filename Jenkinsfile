pipeline {
    agent {
        label 'build-node'  
    }

    environment {
        AWS_DEFAULT_REGION = 'eu-north-1'  
    }

    stages {
        stage('Build') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Package') {
            steps {
                sh 'zip -r flask-app.zip .'
            }
        }
        stage('Upload to S3') {
            steps {
                sh 'aws s3 cp flask-app.zip s3://flask-app-deploy-bucket/'
            }
        }
        stage('Deploy to EC2') {
            steps {
                sh '''
                    aws deploy create-deployment \
                    --application-name EC2CODE \
                    --deployment-group-name deploy-group \
                    --s3-location bucket=flask-app-deploy-bucket,key=flask-app.zip,bundleType=zip
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/flask-app.zip', allowEmptyArchive: true
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}