resource "aws_eip" "demo_epi" {
  count = 2
  vpc   = true
  
  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-epi",
  ))}"
}

resource "aws_nat_gateway" "demo_nat_gateway" {
  count = 2
  allocation_id = "${aws_eip.demo_epi.*.id[count.index]}"
  subnet_id     = "${aws_subnet.demo_subnet_public.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.demo_internet_gateway"]

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-nat-gateway-${count.index}",
  ))}"
}