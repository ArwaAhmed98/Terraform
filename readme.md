### Fully completed guide to deploy NodeJs App on the private ec2 using Jenkins pipelines
# This project contains 
* Infrastructure as code using [Terraform](https://www.terraform.io/) that provision an environment on the [AWS](https://aws.amazon.com/console/).
* Automated [Ansible](https://docs.ansible.com/) scripts that configure the environment.
* Build a Jenkins pipeline to automate the previous tasks
    * Continous integration and delivery for the newely updated infrastructure. 
    * Run a [Docker](https://docs.docker.com/) container on the private ec2. 
# Getting Started
> 1.1 clone the `project` 
 ```bash
git clone https://github.com/ArwaAhmed98/Terraform-aws.git
```

## Step 1 - Setup AWS Account

> 1.1 Setup AWS account and Create IAM USER with Adminstration Permissions

> 1.2 Create an S3 Bucket on your IAM USER account Named with `itisthreee`

> 1.3 Create a Dynamo-db table Named with `terraform-state-lock-dynamo`.Also, Create a key-value record necessary for runtime lock used by terraform with key=`LOCK-ID` and value=leave it blank .
```diff
# TAKECARE
- Make sure that the name of S3 match exactly the name provided in the `Terraform/backend.tf` and Also the region you are working on AWS match the same region provided in `Terraform/terraform.tfvars`.Otherwise, you will get errors.
```
## Step 2  - Configure & Link Jenkins wih AWS Account
```bash
#NOTE:
! OPEN JENKINS DASHBOARD and FOLLOW THE UPCOMING STEPS ON THE DASHBOARD
```
> 2.1 Go to Manage Jenkins > Manage Credentials > Add new Credential > kind: Username with password

> 2.2 put your <AWS_ACCESS_KEY_ID> in the USERNAME text box.

> 2.3 put your <AWS_SECRET_KEY> in the password text box.Click `OK`

> 2.4 repeat the previous step regarding jenkins credentials with type USERNAME with PASSWORD but now for [RDS](https://aws.amazon.com/rds/sqlserver/) USERNAME and PASSWORD for Database that will be created in our infrastructure in `Terraform/rds.tf`.

> 2.5 Configure Terraform Plugin. Go to `Manage Jenkins` > ` Global tool configuration` > Under the Terraform section >  Write in the `NAME:` text box `Terraform` and Select `Terraform v1.1.9 on linux_amd64`
```diff
- Make sure that the Name of tools you configured is the same as the tool Name in the infrastructure pipeline.Otherwise you will get errors.
```
## NOW, you can build the infrastructure pipeline
## Step 3  - Run a pipeline on the private ec2 
```bash
#NOTE:
in order to run a pipeline that starts a docker container for NodeJSApp. we have to connect the private ec2 as a slave for the jenkins FIRST
```
> 3.1 Go to `Manage Jenkins` > `Manage Node and Cloud` > `New Node` > Give it any name and Permanent agent > Create.

> 3.2 Configure the details as shown in the screenshot.
![MarineGEO circle logo](/images/slavesnap.png)

> 3.3 Do not forget to replace the ips provided in the snapshot with your own servers running on AWS.Otherwise, you will get errors.For more detials check this [guide](https://blog.ruanbekker.com/blog/2020/10/26/use-a-ssh-jump-host-with-ansible/)

> 3.4 Click `SAVE` and it will be outputed as `CONNECTED SUCCESSFULLY`
## Step 4  - Prerequistes to Run NodeJs on the privateec2 
> 4.1 Launch [SonarQube](https://www.sonarqube.org/features/multi-languages/?gads_campaign=Row1-SonarQube&gads_ad_group=Multi-Language&gads_keyword=c%20sonarqube&gclid=EAIaIQobChMIo8f2xfij-AIVbY9oCR0odApTEAAYASAAEgKItvD_BwE) using [Helm](https://helm.sh/docs/) on any cluster. I used to launch it on the `minikube` locally.

> 4.2 Sign in on the SonarQube Dashboard using `admin` password `admin` by default. Then, SonarQube will ask you to reset your password.

> 4.3 Sign in again with `admin` user and newely updated password.

> 4.4 On the SonarQube Dashboard, Go to up right corner. Click on `User` > `My Account` > `Security`.

> 4.5 The form at the top of the page allows you to generate new tokens. Click `Generate`.

> 4.6 Copy the token and paste it as a jenkins credentials of type `Secret text` as mentioned eariler in Demo2.
```bash
We also need a file env.list which contains the env var that our app use in "rds_redis" branch. So, we automated this step in the AnsibleAutomation/start.sh in order to get right response whenever do curl localhost:3000/db in the private ec2
```
## Step 5 - Run NodeJs on the privateec2 
> 5.1  On the home page of the jenkins dashboard. Click on `New Item` > `Pipeline` 

> 5.2 Configure your pipeline as shown.![MarineGEO circle logo](/images/pipelinecreation.png "MarineGEO logo")

> 5.3 Click `Save` and Build your pipeline

> 5.4 Now, you can check your containers running on the private ec2 by running `docker ps`. In Addition, you can Check on the SonarQube Dashboard. You will find a code re-view. congrats ! ![MarineGEO circle logo](/images/sonarqube.jpg "MarineGEO logo")
---
```bash
run the following command in the private ec2. `curl localhost:3000/redis` you have to get "redis connected successfully"
```