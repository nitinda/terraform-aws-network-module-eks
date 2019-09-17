resource "aws_subnet" "demo_subnet_db" {
  count             = "${length(var.db_subnets_cidr)}"
  vpc_id            = "${aws_vpc.demo_vpc.id}"
  cidr_block        = "${var.db_subnets_cidr[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-subnet-db-${count.index}",
  ))}"
}
