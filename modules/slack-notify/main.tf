data "google_secret_manager_secret_version" "slack_notify_token" {
  project = var.pipeline_project_id
  secret  = var.slack_notify_secret
}

resource "google_secret_manager_secret" "slack_notify_id" {
  count = var.project_type == "clan_project" ? 1 : 0

  secret_id = data.google_secret_manager_secret_version.slack_notify_token.secret
  labels = {
    terraform = ""
  }
  replication {
    automatic = true
  }
  project = var.project_id
}

resource "google_secret_manager_secret_version" "slack_notify_token_value" {
  count = var.project_type == "clan_project" ? 1 : 0

  secret      = google_secret_manager_secret.slack_notify_id[0].id
  secret_data = data.google_secret_manager_secret_version.slack_notify_token.secret_data
}
