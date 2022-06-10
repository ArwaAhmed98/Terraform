public_ip=`terraform output -raw IPuBlic`
private_ip=`terraform output -raw IPriVate`
REDIS_HOSTNAME=`terraform output -raw REDIS_HOSTNAME`
REDIS_PORT=`terraform output -raw REDIS_PORT`
RDS_HOSTNAME=`terraform output -raw REDIS_HOSTNAME`
RDS_PORT=`terraform output -raw RDS_PORT`
RDS_USERNAME=`terraform output -raw RDS_USERNAME`
RDS_PASSWORD=`terraform output -raw RDS_PASSWORD`
source  override_default_ssh_conf.sh
source  createPlayBooks.sh
source  createEnvListforDocker_NodejsContainer.sh