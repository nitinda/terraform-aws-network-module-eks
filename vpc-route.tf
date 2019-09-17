
### Public Route Table
resource "aws_route_table" "demo_route_table_public" {
  vpc_id = "${aws_vpc.demo_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo_internet_gateway.id}"
  }

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-ecs-route-table-public",
  ))}"
}

### Public Route Table Associaion
resource "aws_route_table_association" "demo_route_table_association_public" {
  count          = "${length(var.public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.demo_subnet_public.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo_route_table_public.id}"
}



### Private Route Table
resource "aws_route_table" "demo_route_table_private" {
  count  = "${length(var.private_subnets_cidr)}"
  vpc_id = "${aws_vpc.demo_vpc.id}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-ecs-route-table-private-${count.index}",
  ))}"
}

### Private Route
resource "aws_route" "demo_route_private" {
  count                  = "${length(var.private_subnets_cidr)}"
  route_table_id         = "${aws_route_table.demo_route_table_private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.demo_nat_gateway.*.id[count.index]}"
  depends_on             = ["aws_route_table.demo_route_table_private"]
}

### Private Route Table Associaion
resource "aws_route_table_association" "demo_route_table_association_private" {
  count          = "${length(var.db_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.demo_subnet_private.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo_route_table_private.*.id[count.index]}"
}



### Database Route Table
resource "aws_route_table" "demo_route_table_db" {
  vpc_id = "${aws_vpc.demo_vpc.id}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-ecs-route-table-db",
  ))}"
}

### Database Route Table Associaion
resource "aws_route_table_association" "demo_route_table_association_db" {
  count          = "${length(var.db_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.demo_subnet_db.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo_route_table_db.id}"
}