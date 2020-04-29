terraform {
  # The configuration for this backend will be filled in by Terragrunt
  required_version = ">= 0.12.18"
}

provider "google" {
  version     = "~> 3.8"
  region      = "europe-west-1"
  credentials = var.credentials
}

provider "google-beta" {
  region      = "europe-west-1"
  credentials = var.credentials
}

provider "gsuite" {
  impersonated_user_email = coalesce(var.impersonated_user_email, format("%s@%s", "terraform", var.domain))

  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.group.member"
  ]

  version = "~> 0.1.35"
}
