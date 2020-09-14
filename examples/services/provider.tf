terraform {
  # The configuration for this backend will be filled in by Terragrunt
  required_version = ">= 0.12.18"
}

provider "google" {
  version     = "~> 2.7"
  region      = "europe-west-1"
}

provider "gsuite" {
  impersonated_user_email = "terraform@extenda.io"

  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.group.member"
  ]

  version = "~> 0.1.35"
}
