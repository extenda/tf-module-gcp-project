data "google_secret_manager_secret_version" "pactbroker_user" {
  project = var.pact_project_id
  secret  = var.pactbroker_user_secret
}

data "google_secret_manager_secret_version" "pactbroker_pass" {
  project = var.pact_project_id
  secret  = var.pactbroker_pass_secret
}

resource "google_secret_manager_secret" "user_secret_id" {
  count     = var.create_pact_secrets ? 1 : 0

  secret_id = data.google_secret_manager_secret_version.pactbroker_user.secret

  labels = {
    terraform = ""
  }

  replication {
    automatic = true
  }
  project = var.project_id
}

resource "google_secret_manager_secret_version" "user_secret_value" {
  count    = var.create_pact_secrets ? 1 : 0

  secret      = google_secret_manager_secret.user_secret_id[0].id
  secret_data = data.google_secret_manager_secret_version.pactbroker_user.secret_data
}

resource "google_secret_manager_secret" "pass_secret_id" {
  count    = var.create_pact_secrets ? 1 : 0

  secret_id = data.google_secret_manager_secret_version.pactbroker_pass.secret

  labels = {
    terraform = ""
  }

  replication {
    automatic = true
  }
  project = var.project_id
}

resource "google_secret_manager_secret_version" "pass_secret_value" {
  count    = var.create_pact_secrets ? 1 : 0

  secret      = google_secret_manager_secret.pass_secret_id[0].id
  secret_data = data.google_secret_manager_secret_version.pactbroker_pass.secret_data
}
