resource "aws_dynamodb_table" "visitor_count_table" {
  name         = var.visitor_count_table_name
  billing_mode = var.billing_mode
  hash_key     = var.attribute_name
  attribute {
    name = var.attribute_name
    type = "S"
  }
}
