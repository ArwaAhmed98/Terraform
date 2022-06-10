public_ip=`terraform -chdir=./Terraform/ output -raw IPuBlic`
private_ip=`terraform -chdir=./Terraform/ output -raw IPriVate`
REDIS_HOSTNAME=`terraform -chdir=./Terraform/ output -raw REDIS_HOSTNAME`
REDIS_PORT=`terraform -chdir=./Terraform/ output -raw REDIS_PORT`
RDS_HOSTNAME=`terraform -chdir=./Terraform/ output -raw REDIS_HOSTNAME`
RDS_PORT=`terraform -chdir=./Terraform/ output -raw RDS_PORT`
RDS_USERNAME=`terraform -chdir=./Terraform/ output -raw RDS_USERNAME`
RDS_PASSWORD=`terraform -chdir=./Terraform/ output -raw RDS_PASSWORD`
source  override_default_ssh_conf.sh
source  createPlayBooks.sh
source  createEnvListforDocker_NodejsContainer.sh