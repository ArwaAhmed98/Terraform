cp /var/jenkins_home/workspace/infra/private_key.pem ~/.ssh/
chmod 600 ~/.ssh/private_key.pem
cat << EOF > ~/.ssh/config
host bastion
   HostName ${public_ip}
   User ubuntu
   identityFile ~/.ssh/private_key.pem

host private_instance
   HostName  ${private_ip}
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile ~/.ssh/private_key.pem
EOF
