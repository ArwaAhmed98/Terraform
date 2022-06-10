pipeline {
    agent any
    tools {
        terraform 'Terraform' 
    }
    stages {
        stage('terraformPlan') {
            steps {
                withCredentials(usernamePassword(credentialsId:'aws-cred')) {
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
        stage('TriggerAnsibleScripts'){
            steps{
                    sh """
                    chmod 777 AnsibleAutomation/start.sh
                    source AnsibleAutomation/start.sh
                    pwd
                    cd ansible/
                    ansible-playbook -i inventory installjava.yml
                    ansible-playbook -i inventory docker.yml
                    ansible-playbook -i inventory copyagent.yml
                """
            }
        }
    }   
}
// pwd inside the pipepline gives /var/jenkins_home/workspace/<pipeline_name>