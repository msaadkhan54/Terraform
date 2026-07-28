resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "saad-dynamodb-table-1"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "saad-dynamodb-table-1"
  }
}

resource "aws_s3_bucket" "s3-remote" {
  bucket="saad-bucket-remote"
  tags = {
    Name = "saad-bucket-remote" 
  }

}

