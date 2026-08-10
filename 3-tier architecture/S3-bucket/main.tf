resource "aws_s3_bucket" "s3-bucket" {
  bucket = "s3-bucket"
  tags = {
   Name="saad-s3-bucket" 
  }
}