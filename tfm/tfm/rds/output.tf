output "db_hostname" {
  value = aws_db_instance.jom_rds.db_name
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_access_secret.arn
}
