resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.public_subnets)}"
  vpc_id            = aws_vpc.vpc.id
   cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"  # Modify AZ as needed
    map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-jom-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = "${length(var.private_subnets)}"
  vpc_id            = aws_vpc.vpc.id
   cidr_block              = "${var.private_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"  # Modify AZ as needed
    map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-jom-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
    ManagedBy = "Terraform"
  }
}