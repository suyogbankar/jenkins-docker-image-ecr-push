pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = "750311440941"
        AWS_DEFAULT_REGION = "ap-south-1"
        IMAGE_REPO_NAME = "jenkins-ecr-repo"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage('Logging into AWS ECR') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-ecr-project',
                )]) {
                    sh '''
                        aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | \
                        docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
                    '''
                }
            }
        }

        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                    extensions: [],
                    userRemoteConfigs: [[credentialsId: 'jenkins-ecr-123', url: 'https://github.com/suyogbankar/jenkins-docker-image-ecr-push.git']]
                ])
            }
        }

        stage('Building image') {
            steps {
                script {
                    sh 'docker buildx create --use --name jenkins-builder || true'
                    sh """
                        docker buildx build \
                        -t ${REPOSITORY_URI}:${IMAGE_TAG} \
                        --platform linux/amd64 \
                        --load .
                    """
                }
            }
        }

        stage('Pushing to ECR') {
            steps {
                sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
            }
        }
    }
}



// pipeline {
//     agent any

//     environment {
//         AWS_ACCOUNT_ID = "750311440941"
//         AWS_DEFAULT_REGION = "ap-south-1"
//         IMAGE_REPO_NAME = "jenkins-ecr-repo"
//         IMAGE_TAG = "latest"
//         REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
//     }

//     stages {

//         stage('Logging into AWS ECR') {
//             steps {
//                 script {
//                     sh """
//                      aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}
//                      """
//                 }
//             }
//         }

//         stage('Cloning Git') {
//             steps {
//                 checkout([$class: 'GitSCM', branches: [[name: '*/master']],
//                     extensions: [],
//                     userRemoteConfigs: [[credentialsId: 'jenkins-ecr-123', url: 'https://github.com/suyogbankar/jenkins-docker-image-ecr-push.git']]
//                 ])
//             }
//         }

//         stage('Building image') {
//             steps {
//                 script {
//                    sh 'docker buildx create --use --name jenkins-builder || true'
//                    sh """
//                         docker buildx build \
//                         -t ${REPOSITORY_URI}:${IMAGE_TAG} \
//                         --platform linux/amd64 \
//                         --load .
//                    """
//                 }
//             }
//         }

//         stage('Pushing to ECR') {
//             steps {
//                 script {
//                     sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
//                 }
//             }
//         }
//     }
// }



// pipeline {
//     agent any
//     environment {
//         AWS_ACCOUNT_ID="750311440941"
//         AWS_DEFAULT_REGION="ap-south-1"
//         IMAGE_REPO_NAME="jenkins-docker-image-ecr-push"
//         IMAGE_TAG="latest"
//         REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
//     }

//     stages {
//         stage('Logging into AWS ECR') {
//             script {
//                 sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
//             }
//         }

//         stage('Cloning Git') {
//             steps {
//                 checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/suyogbankar/jenkins-docker-image-ecr-push.git']]])     
//             }
//         }

//         // Building Docker images
//         stage('Building image') {
//             steps{
//                 script {
//                     dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
//                 }
//             }
//         }

//         // Uploading Docker images into AWS ECR
//         stage('Pushing to ECR') {
//             steps {
//                 script {
//                     sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"""
//                     sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
//                 }
//             }
//         }
//     }

// }