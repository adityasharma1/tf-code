def projectId = "mar-roidtc304"

pipeline {
   agent any

   stages {
        stage('Stage 1 - workspace and versions') {
                        
            steps {
                echo '****************************** Stage 1'
                sh 'echo $WORKSPACE'
                //sh 'docker --version'
                sh 'gcloud version'
                sh 'nodejs -v'
                sh 'npm -v'
            }
        }
        stage('Stage 2 - build external') {
            // setting env variable so external default port does not conflict with jenkins
            environment {
                PORT = 8081
            }
            steps {
                echo '****************************** Stage 2'
                dir("${env.WORKSPACE}/external"){
                    echo 'Retrieving source from github' 
                    git branch: 'master',
                        url: 'https://github.com/adityasharma1/Deloitted_external.git'
                    echo 'Did we get the source?' 
                    sh 'ls -a'
                    echo 'install dependencies' 
                    sh 'npm install'
                    echo 'Run tests'
                    sh 'npm test'
                    echo 'Tests passed on to build Docker container'
                    echo "build id = ${env.BUILD_ID}"
                    sh "gcloud builds submit -t gcr.io/${projectId}/external-image:v2.${env.BUILD_ID} ."
                }
            }
        }
        // /*stage('Stage 3 - build internal') {
        //     steps {
        //         echo '****************************** Stage 3'
        //         /*dir("${env.WORKSPACE}/internal"){
        //           echo 'Retrieving source from github' 
        //             git branch: 'master',
        //                 url: 'https://github.com/KevinRattan/terraform-jenkins-k8s-internal.git'
        //             sh "ls -a"
        //             echo 'install dependencies' 
        //             sh 'npm install'
        //             echo 'Run tests'
        //             sh 'npm test'
        //             echo 'Tests passed on to build Docker container'
        //             echo "build id = ${env.BUILD_ID}"
        //             sh "gcloud builds submit -t gcr.io/${projectId}/internal:v20.${env.BUILD_ID} ."
        //         }*/
        //     }
        // }*/
        stage('Stage 5') {
            steps {
                echo 'Get cluster credentials'
                sh 'gcloud container clusters get-credentials deloitted-cluster --zone us-central1-c --project mar-roidtc304'
                echo 'Update the image'
                echo "gcr.io/mar-roidtc304/internal:2.${env.BUILD_ID}"
                sh "kubectl set image deployment/events-external events-external=gcr.io/mar-roidtc304/external-image:v2.${env.BUILD_ID} --record"
            }
        }

   }
}