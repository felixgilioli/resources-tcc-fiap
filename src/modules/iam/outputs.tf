output "role_arn" {
  value = aws_iam_role.app_role.arn
}

output "role_name" {
  value = aws_iam_role.app_role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.app_profile.name
}