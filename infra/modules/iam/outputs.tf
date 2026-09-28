output "role_arn" {
  description = "ARN of the created role, for the eks.amazonaws.com/role-arn annotation"
  value       = aws_iam_role.app.arn
}

output "role_name" {
  value = aws_iam_role.app.name
}
