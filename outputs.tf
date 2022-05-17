output vpc_id {
    value = module.network.vpc_id
  
}
output "ec2_global_ips" {
  value = ["${aws_instance.pubec2.*.public_ip}",""]
}
# privateec2