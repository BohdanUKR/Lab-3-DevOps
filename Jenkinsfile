pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout your Maven Java Webapp code from version control
                // For example, if you are using Git:
                checkout([$class: 'GitSCM',
                          branches: [[name: 'main']],
                          doGenerateSubmoduleConfigurations: false,
                          extensions: [],
                          submoduleCfg: [],
                          userRemoteConfigs: [[url: 'https://github.com/BohdanUKR/Lab-3-DevOps.git']]
                ])
            }
        }

        stage('Build') {
            steps {
                // Build your Maven Java Webapp
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build a Docker image using the Dockerfile in your project
                script {

                    //withDockerRegistry([credentialsId: '00bb224e-e38b-4d38-9753-1ed094414296', url: ''])
                 //bat "docker push danukr/firstrepository:build"
                def dockerImage = docker.build("danukr/firstrepository:${env.BUILD_NUMBER}")
                withDockerRegistry([credentialsId: '00bb224e-e38b-4d38-9753-1ed094414296', url: 'https://registry.hub.docker.com'])
               {
                 dockerImage.push()
               }
               //def registry_url = "registry.hub.docker.com/"
               //bat "docker login -u $USER -p $PASSWORD ${registry_url}"
        //docker.withRegistry("http://${registry_url}", "00bb224e-e38b-4d38-9753-1ed094414296") {
            // Push your image now
            //bat "docker push danukr/firstrepository:build"
                }
            }
        }

        stage('Cleanup') {
            steps {
                // Clean up any Docker containers or images
                sh 'docker system prune -af'
            }
        }

        stage('Deploy') {
            steps {
                // Pull the Docker image from Docker Hub and run it
                sh "docker pull danukr/firstrepository:${env.BUILD_NUMBER}"
                sh "docker run -d -p 8080:8080 danukrfirstrepository:${env.BUILD_NUMBER}"
            }
        }
    }
}