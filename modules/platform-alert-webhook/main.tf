data "google_secret_manager_secret_version" "platform_alert_webhook" {
  project = var.pipeline_project_id
  secret  = var.webhook_url_secret
}

resource "google_secret_manager_secret" "platform_alert_secret_id" {
  count = var.project_type == "clan_project" ? 1 : 0

  secret_id = data.google_secret_manager_secret_version.platform_alert_webhook.secret
  labels = {
    terraform = ""
  }
  replication {
    automatic = true
  }
  project = var.project_id
}

resource "google_secret_manager_secret_version" "platform_alert_secret_value" {
  count = var.project_type == "clan_project" ? 1 : 0

  secret      = google_secret_manager_secret.platform_alert_secret_id[0].id
  secret_data = data.google_secret_manager_secret_version.platform_alert_webhook.secret_data
}
