pipeline {
    agent any
    environment{
        DOCKERHUB_CREDENTIALS = credentials('docker_key')
        build_number = "${env.BUILD_ID}"
        AWS_ACCOUNT_ID="170771122394"
        AWS_DEFAULT_REGION="ap-south-1"
        IMAGE_REPO_NAME="new"
        IMAGE_TAG="1.1"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
    stages{
        stage('git checkout'){
            steps{
                git branch: 'main', credentialsId: 'git_key', url: 'https://github.com/rajeeb007/newforhelm.git'
            }
        }
        stage('code scanner') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonar_key',installationName:'sonarqube') {
                    sh 'mvn sonar:sonar'
    
               }
            
            }
        }
        stage('docker image building') {

            steps {

                sh 'docker build -t rajeeb007/for_helm:1.5 .'
               
            }

        }
        stage('Login') {

            steps {

                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'

            }

        }
        stage('pushing to docker hub') {

            steps {

                sh 'docker push rajeeb007/for_helm:1.5'

            }

        }
        stage('helmChart tag and  push to ECR') {
            steps {
                sh "cd helmnew/"
                def newImageVersion = '1.8'
                sh "sed -i 's|rajeeb007/for_helm:1.5|rajeeb007/for_helm:${newImageVersion}|g' helmnew/values.yaml"

            }
        }
        stage('helm package '){
            
            steps {
                sh "helm package helmnew/"
            }
            
        }    

    }
}