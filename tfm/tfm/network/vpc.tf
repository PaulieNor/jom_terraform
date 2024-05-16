

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16" # Modify CIDR block as needed
  enable_dns_hostnames = true
  tags = {
        Name = "${var.env}-jom-vpc"
        ManagedBy = "Terraform"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Create a public subnet



# Create a route table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-rt"
    ManagedBy = "Terraform"
  }
}

# Associate public subnet with the public route table
resource "aws_route_table_association" "public_route_association" {
  count = "${length(aws_subnet.public_subnet)}"
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}