pipeline {
    agent any
    stages {
        stage('terraformPlan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentails', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    terraform -chdir=Terraform/ init
                    terraform -chdir=Terraform/ plan
                    terraform -chdir=Terraform/ fmt
                    """
                    }
                }
            }
        stage('terraformApply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'rdsdb', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                        terraform -chdir=Terraform/ workspace select dev 
                        terraform -chdir=Terraform/ apply --auto-approve  -var-file "dev.tfvars" -var "username=${USERNAME}" -var "password=${PASSWORD}"  
                        '''
                }
                //  terraform apply --auto-approve  -var-file "dev.tfvars"  -var "username=${USERNAME}" -var "password=${PASSWORD}"
                // terraform apply --auto-approve -var="password=$(PASS)"
                // terraform apply \
                //     -var-file 'production.tfvars' \
                //     -var-file 'secrets.tfvars'   
            }
        }
    }   
}