resource "aws_iam_role" "db_secret_access_role" {
  name               = "${var.env}-db-secret-access-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${var.account_id}:oidc-provider/${var.oidc_provider}"
        }
        Action    = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.oidc_provider}:aud" = "sts.amazonaws.com"
            "${var.oidc_provider}:sub" = "system:serviceaccount:s3-upload:db-secret-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "db_secret_policy_role_attachment" {
  policy_arn = aws_iam_policy.db_secret_access_policy.arn
  role       = aws_iam_role.db_secret_access_role.id
}