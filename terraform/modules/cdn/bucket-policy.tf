data "aws_iam_policy_document" "frontend_bucket_policy" {

  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${var.frontend_bucket_arn}/*"
    ]

    principals {
      type = "Service"

      identifiers = [
        "cloudfront.amazonaws.com"
      ]
    }

    condition {
      test = "StringEquals"

      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.frontend.arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "frontend" {

  bucket = split(":::", var.frontend_bucket_arn)[1]

  policy = data.aws_iam_policy_document.frontend_bucket_policy.json
}