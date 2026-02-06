def registry = 'https://ismaililica.jfrog.io/'
def imageName = 'ismaililica.jfrog.io/iso-docker-local/devops-project-o2'
def version = '2.1.3'
pipeline {
    agent {
        node{
            label 'maven-slave'
        }
    }

environment{
    PATH = "/opt/apache-maven-3.9.12/bin:$PATH"
}
    
    stages {
        stage("build"){
            
            steps{
                
                echo "--------build started--------"
                sh 'mvn clean deploy -DskipTests'
                echo "--------build completed--------"
               

            }


        }

        stage("Test"){

            steps{
                echo "--------unit test started--------"
                sh 'mvn surefire-report:report'
                echo "--------unit test completed--------"
            }
        }


        stage("SonarQube analysis") {
    steps {
        withSonarQubeEnv('sonarqube-server') {
            sh """
              mvn  sonar:sonar \
              -DskipTests \
              -Dsonar.projectKey=Ismaililica_Devops-End-to-End-Pipeline
            """
        }
    }
}

      /* stage("Quality Gate") {
    steps {
        script {
            timeout(time: 5, unit: 'MINUTES') {
                def qg = waitForQualityGate()
                echo "Quality Gate status: ${qg.status}"

                if (qg.status != 'OK') {
                    error "Pipeline stopped due to Quality Gate: ${qg.status}"
                }
            }
        }
    } 
}
*/

     
         stage("Jar Publish jfrog") {
         steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifact-cred"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "devops-libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    } 


    stage("Docker Build"){
       steps{

              script{
                
                echo '-------------------Docker Build Started---------------------'
                app = docker.build(imageName+":"+version)
                echo  '------------------Docker Build End-------------------------'
                }

             }
    }

    stage("Docker Publish"){

        steps{
             
             script{
                  
               echo '--------------------Docker Publish Started---------------------'
               docker.withRegistry(registry,'artifact-cred'){
                app.push()
               }
              
              echo '---------------------Docker Publish End-------------------------'
             }
        }
    }
 
    /*stage("Deploy"){

     steps{
        script{

            sh './deploy.sh'
        }
     }
    }
    */




    }
}
