resource "aws_subnet" "demo_subnet_public" {
  count             = "${length(var.public_subnets_cidr)}"
  vpc_id            = "${aws_vpc.demo_vpc.id}"
  cidr_block        = "${var.public_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-subnet-public-${count.index}",
  ))}"
}