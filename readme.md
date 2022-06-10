
# This project contains 
* Infrastructure as code using [Terraform](https://www.terraform.io/) that provision an environment on the [AWS](https://aws.amazon.com/console/).
* Automated [Ansible](https://docs.ansible.com/) scripts that configure the environment.
* Build a Jenkins pipeline to automate the previous tasks
    * Continous integration and delivery for the newely updated infrastructure. 
    * Run a [Docker](https://docs.docker.com/) container on the private ec2. 
# Getting Started
### Demo 1 - Build your infrastructure on AWS using jenkins pipeline

> 1.1 clone the `project` 
 ```bash
git clone https://github.com/ArwaAhmed98/Terraform-aws.git
``` 
> 1.2 Setup AWS account and Create IAM USER with Adminstration Permissions

> 1.3 Create an S3 Bucket on your IAM USER account Named with `itisthreee`

> 1.4 Create a Dynamo-db table Named with `terraform-state-lock-dynamo`.Also, Create a key-value record in the table with key = `LOCK-ID` and vlaue blank necessary for runtime lock used by terraform.
<!-- <ol>
    <li>option 1</li>
    <li>option 2</li>
    <li>option 3</li>
</ol> -->
<!-- - make lambda function using python code to send email with a change in the infrastructure (workspace statefiles)[s3 + Lambda + ses]
- implement two workspace one for the dev and other for the production
- make a basition host ( ssh on the private ec2 from the public ec2 using same ssh key )
- Make the Network in Seperate module and reuse it 
- install Mysql Server on 2 private ec2 and attach it to private sg  -->

<!-- ![MarineGEO circle logo](/images/sonarqube.png "MarineGEO logo") -->

