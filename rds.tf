resource "aws_db_instance" "myrds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
#   username             = "foo"
    username = var.username
#   password             = "foobarbaz"
    # password = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name =  aws_db_subnet_group.mydb.name 
  vpc_security_group_ids = [ aws_security_group.privatesg.id ]
}

resource "aws_db_subnet_group" "mydb" {
  name       = "dbmysql"
 subnet_ids = [module.network.priv_sub1_id , module.network.priv_sub2_id]

  tags = {
    Name = "Mysql with rds DB subnet group"
  }
}   