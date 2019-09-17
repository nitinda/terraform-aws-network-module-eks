resource "aws_internet_gateway" "demo_internet_gateway" {
  vpc_id = "${aws_vpc.demo_vpc.id}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-internet-gateway",
  ))}"
}