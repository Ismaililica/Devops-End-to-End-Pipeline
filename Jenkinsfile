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

        stage("Quality Gate") {
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



    }
}
