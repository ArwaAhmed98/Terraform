module network {
    source = "./network"
    vpc_cidr= var.vpc_cidr
    name=var.name
    public_sub1_cidr= var.public_sub1_cidr
    public_sub2_cidr= var.public_sub2_cidr
    private_sub1_cidr= var.private_sub1_cidr
    private_sub2_cidr= var.private_sub2_cidr
    region=var.region

}