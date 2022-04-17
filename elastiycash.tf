resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  security_group_ids = [aws_security_group.privatesg.id]
  subnet_group_name = aws_elasticache_subnet_group.bar.name
}


resource "aws_elasticache_subnet_group" "bar" {
  name       = "tf-test-cache-privatesubnet"
  subnet_ids = [module.network.priv_sub1_id , module.network.priv_sub2_id]
}