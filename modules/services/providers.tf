terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    googleworkspace = {
      source = "hashicorp/googleworkspace"
      version = "~> 0.7.0"
    }
  }
}
