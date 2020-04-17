variable parent_project_id {
  type        = string
  description = "ID of the project to which add additional IAM roles for current project's CI/CD service account. Don't add roles if value is empty"
}

variable service_account {
  type        = string
  description = "Service account email to add IAM roles in parent project for"
}

variable parent_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to the parent project"
}
