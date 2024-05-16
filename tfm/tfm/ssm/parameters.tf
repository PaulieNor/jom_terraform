resource "aws_ssm_parameter" "s3_upload_bucket_name_store" {
  name  = "upload-bucket-name"
  type  = "String"
  value = var.tfm_bucket_name
}