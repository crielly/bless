resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.rcdf.id}"

    tags {
        Name = "main"
        Terraform   = "True"
    }
}

resource "aws_route_table" "main" {
    vpc_id     = "${aws_vpc.rcdf.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags {
        Name = "main"
        Terraform   = "True"
    }
}

resource "aws_route_table_association" "infrastructure" {
    subnet_id      = "${aws_subnet.infrastructure.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "prod-a" {
    subnet_id      = "${aws_subnet.prod-a.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "prod-b" {
    subnet_id      = "${aws_subnet.prod-b.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "prod-c" {
    subnet_id      = "${aws_subnet.prod-c.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "dev-a" {
    subnet_id      = "${aws_subnet.dev-a.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "dev-b" {
    subnet_id      = "${aws_subnet.dev-b.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "dev-c" {
    subnet_id      = "${aws_subnet.dev-c.id}"
    route_table_id = "${aws_route_table.main.id}"
}