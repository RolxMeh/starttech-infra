resource "aws_cloudfront_origin_access_control" "frontend" {
  name        = "starttech-oac"
  description = "Origin Access Control for StartTech frontend bucket"

  origin_access_control_origin_type = "s3"

  signing_behavior = "always"

  signing_protocol = "sigv4"
}