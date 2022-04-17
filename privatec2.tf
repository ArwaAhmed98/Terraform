
resource "aws_instance" "privateec2" {
  ami           = "ami-04505e74c0741db8d" #ubuntu
  instance_type = "t2.micro"
  subnet_id = module.network.priv_sub1_id
  associate_public_ip_address = false
  vpc_security_group_ids = ["${aws_security_group.privatesg.id}"] #attach ec2 to public secuirty group
  key_name = "pub-key"
  tags = {
    Name = "privatec2"
  }
}