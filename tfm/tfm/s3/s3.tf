resource "aws_s3_bucket" "uploaded_assets_bucket" {
  bucket = "${var.env}-s3-uploaded-assets-bucket-22222"
}