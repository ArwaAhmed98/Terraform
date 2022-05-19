pipeline {
    agent any
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
    //     AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    // }
    stages {
        stage('Plan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentails', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                  
                    sh """
                    terraform init
                    terraform plan
                    terraform fmt
                    """
                    
                    }
                }
            }
        stage('Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'rdsdb', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                        terraform workspace select dev 
                        terraform apply --auto-approve  -var "username=$(USERNAME)" -var "password=$(PASSWORD)"
                        '''
                }
                // terraform apply --auto-approve -var="password=$(PASS)"
                // terraform apply \
                //     -var-file 'production.tfvars' \
                //     -var-file 'secrets.tfvars'
                        
            }
        }
     
    }   
}