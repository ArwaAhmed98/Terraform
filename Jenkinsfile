pipeline {
    agent any
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
    //     AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    // }
    stages {
        stage('CIinitPlan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentails', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                  
                    sh """
                    terraform init
                    terraform plan
                    terraform fmt
                    """
                    
                    }
                // 
            }
        }
        stage('CDApply') {
            steps {
                sh """
                export username=foo
                export password=foobarbaz
                terraform workspace select dev 
                terraform apply --auto-approve -var-file dev.tfvars
                
                """
            }
        }
     
    }   
}