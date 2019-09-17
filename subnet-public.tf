resource "aws_subnet" "demo_subnet_public" {
  count             = "${length(var.public_subnets_cidr)}"
  vpc_id            = "${aws_vpc.demo_vpc.id}"
  cidr_block        = "${var.public_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-subnet-public-${count.index}",
    "kubernetes.io/cluster/${var.cluster_name}", "owned",
    "kubernetes.io/role/elb", "1",
    "kubernetes.io/ingress.class", "alb",
    "alb.ingress.kubernetes.io/scheme", "internet-facing", 
  ))}"
}