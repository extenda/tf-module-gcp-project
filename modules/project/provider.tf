terraform {
  # The configuration for this backend will be filled in by Terragrunt
  required_version = ">= 0.12.18"
}

provider "google" {
  version     = "~> 2.7"
  region      = "europe-west-1"
  credentials = var.credentials
}
