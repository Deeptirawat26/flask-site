pipeline {
    agent any

    environment {
        AWS_CREDENTIALS_ID = 'AKIATCKASUDANOB4SKR4'
        S3_BUCKET = 'flask-app-deploy-bucket'
        ZIP_FILE = 'flask-site.zip'
        CODEDEPLOY_APPLICATION_NAME = 'EC2CODE'
        CODEDEPLOY_DEPLOYMENT_GROUP = 'deploy-group'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git url: 'https://github.com/Deeptirawat26/flask-site.git', branch: 'main'
            }
        }
        stage('Zip') {
            steps {
                // Create a zip archive of the project
                sh 'zip -r ${ZIP_FILE} .'
            }
        }
        stage('Upload to S3') {
            steps {
                // Upload the zip file to S3
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh "aws s3 cp ${ZIP_FILE} s3://${S3_BUCKET}/"
                }
            }
        }
        stage('Deploy') {
            steps {
                // Trigger CodeDeploy deployment
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh """
                        aws deploy create-deployment \
                        --application-name ${CODEDEPLOY_APPLICATION_NAME} \
                        --deployment-group-name ${CODEDEPLOY_DEPLOYMENT_GROUP} \
                        --s3-location bucket=${S3_BUCKET},key=${ZIP_FILE},bundleType=zip
                    """
                }
            }
        }
    }

    post {
        always {
            // Archive the zip file for record-keeping
            archiveArtifacts artifacts: "${ZIP_FILE}", allowEmptyArchive: true
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
