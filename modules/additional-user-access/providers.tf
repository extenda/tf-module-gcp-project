terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    gsuite = {
      source = "DeviaVir/gsuite"
      version = "~> 0.1.62"
    }
  }
}
