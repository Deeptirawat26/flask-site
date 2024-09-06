pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Install the required packages
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        stage('Package') {
            steps {
                script {
                    // Package the Flask app into a zip file
                    sh 'zip -r flask-app.zip .'
                }
            }
        }
        stage('Upload to S3') {
            steps {
                script {
                    // Upload the zip file to S3
                    sh 'aws s3 cp flask-app.zip s3://flask-app-deploy-bucket/'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    // Create a deployment in CodeDeploy
                    sh 'aws deploy create-deployment \
                        --application-name EC2CODE \
                        --deployment-group-name deploy-group \
                        --revision revisionType=S3,s3Location={bucket=flask-app-deploy-bucket,key=flask-app.zip,bundleType=zip}'
                }
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
