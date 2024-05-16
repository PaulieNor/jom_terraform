resource "aws_ecr_repository" "jom_ecr_repo" {
  count                   = "${length(var.repos)}"
  name                 = "${var.env}-${var.repos[count.index]}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}