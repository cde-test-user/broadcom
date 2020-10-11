properties([pipelineTriggers([githubPush()])])
 
pipeline {
    /* specify nodes for executing */
    agent {
        label 'master'
    }
 
    stages {
        /* checkout repo */
        stage('Checkout SCM') {
            steps {
             git branch: "${BRANCH_NAME}", credentialsId: 'githubuser', url: 'https://github.com/evyacik/broadcom.git'
            }
        }
         stage('Bulid') {
            steps {
                sh './mvnw clean install'
            }
        }
    }
 
    /* Cleanup workspace */
    post {
       always {
           deleteDir()
       }
   }
}
