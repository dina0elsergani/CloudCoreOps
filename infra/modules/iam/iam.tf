resource "aws_iam_role" "app" {
  name = "cloudcoreops-app"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  # Attach only necessary policies
} 