output "vpc_id" {
  description = "the id of vpc"
  value = module.network.vpc_id
}
output "private_key" {
  value = tls_private_key.private_key_pair.private_key_pem
  sensitive = true
}
output "IPuBlic" {
  description = "The public ip of ec2 [basition host]"
  value = aws_instance.pubec2.public_ip
}
output "IPriVate" {
  description = "private ip of private ec2"
  value = aws_instance.privateec2.private_ip
}
output "RDS_HOSTNAME" {
  description = "The address of RDS"
  value = aws_db_instance.myrds.address
}
output "RDS_USERNAME" {
  description = "The username of RDS"
  value = aws_db_instance.myrds.username
}
output "RDS_PASSWORD" {
  description = "The Password of RDS"
  value = aws_db_instance.myrds.password
  sensitive = true
}
output "RDS_PORT" {
  description = "The port of RDS"
  value = aws_db_instance.myrds.port
}
output "REDIS_HOSTNAME" {
  description = "endpoint of redis host"
  value = aws_elasticache_cluster.example.cache_nodes[0].address
}
output "REDIS_PORT" {
  description = "the port of the redis"
  value = aws_elasticache_cluster.example.port
}