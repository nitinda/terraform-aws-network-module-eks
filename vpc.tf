resource "aws_vpc" "demo_vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-vpc",
  ))}"
}