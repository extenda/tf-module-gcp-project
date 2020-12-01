data "google_client_config" "default" {
}

provider "kubernetes" {
  load_config_file = false

  host  = "https://${var.gke_host}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    var.gke_ca_certificate,
  )
}
