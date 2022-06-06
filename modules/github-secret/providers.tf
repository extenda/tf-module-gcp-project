terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.26.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}
