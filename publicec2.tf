resource "aws_instance" "pubec2" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id = module.network.pub_sub1_id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.publicsg.id}"] #attach ec2 to public secuirty group
  key_name = "pub-key"
  tags = {
    Name = "publicec2"
  }
}




###################################################################################################

resource "aws_instance" "pubec22" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id = module.network.pub_sub2_id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.publicsg.id}"] #attach ec2 to public secuirty group
  key_name = "pub-key"
  tags = {
    Name = "publicec22"
  }
}