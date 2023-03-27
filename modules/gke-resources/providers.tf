terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
}

data "google_client_config" "default" {
}

provider "kubernetes" {
  host  = "https://${var.gke_host}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    var.gke_ca_certificate,
  )
}