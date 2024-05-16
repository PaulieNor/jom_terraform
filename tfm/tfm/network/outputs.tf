output "subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
  
}