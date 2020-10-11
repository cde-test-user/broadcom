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
                sh 'docker build . -t broadcom:latest'
            }
        }
         stage('Deploy') {
            steps {
                sh """
                if [ ! "\$(docker ps -q -f name=broadcom)" ]; then
                    if [ "\$(docker ps -aq -f status=exited -f name=broadcom" ]; then
                        # cleanup
                        docker rm -f broadcom
                    fi
                    # running container
                    docker run -d -p 8080:8080 --name broadcom broadcom:latest
                fi
                """
            }
        }
        stage('Test URL') {
            steps {
                sh """
               response_code=\$(curl -s -o /dev/null -w '%{http_code}' http://34.107.84.207:8080/)
               if [ \${response_code} -eq 200 ]; then
                echo "URL returns status code 200"
               else
                echo "Error, URL returns status code: \${response_code}"
                exit 1
               fi
               
                """
            }
        }
    }
 
    post {
       always {
           archiveArtifacts artifacts: 'target/surefire-reports/*.xml', followSymlinks: false, onlyIfSuccessful: true
           junit 'target/surefire-reports/*.xml'
       }
   }
}
