terraform {
  # The configuration for this backend will be filled in by Terragrunt
  required_version = ">= 0.12.18"
  required_providers {
    google = {
      source = "hashicorp/google"
      version     = "~> 3.8"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
    gsuite = {
      source = "DeviaVir/gsuite"
      version = "~> 0.1.62"
    }
  }
}

provider "google" {
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
}
