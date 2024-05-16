resource "aws_security_group" "db_security_group" {
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-db-security-group"
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "db_allow_ingress_postgres" {
    type = "ingress"
  security_group_id = aws_security_group.db_security_group.id
  cidr_blocks         = [aws_vpc.vpc.cidr_block]
  from_port         = 5432
  protocol       = "tcp"
  to_port           = 5432
}

resource "aws_security_group_rule" "db_allow_egress" {
    type = "egress"
  security_group_id = aws_security_group.db_security_group.id
  cidr_blocks         = [aws_vpc.vpc.cidr_block]
  from_port         = 0
  protocol       = "-1"
  to_port           = 0
}