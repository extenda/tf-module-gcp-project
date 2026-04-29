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
    googleworkspace = {
      source = "hashicorp/terraform-provider-googleworkspace"
      version = "~> 0.7.0"
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

# The customer id provided with your Google Workspace subscription
# customer_id: "C03czrdxq"
# Might need to add customer_id to the provider, 
provider "googleworkspace" {
  impersonated_user_email = coalesce(var.impersonated_user_email, format("%s@%s", "terraform", var.domain))

  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.group.member"
  ]
}
