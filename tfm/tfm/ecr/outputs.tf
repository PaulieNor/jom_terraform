output "ecr_repo_arn" {
    value = [aws_ecr_repository.jom_ecr_repo[*].arn]
  
}