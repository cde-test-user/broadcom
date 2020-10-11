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
                git credentialsId: 'githubuser', url: "https://github.com/evyacik/broadcom.git"
            }
        }
         stage('Do the deployment') {
            steps {
                echo ">> Run deploy applications "
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
