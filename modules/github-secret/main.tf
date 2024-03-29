data "google_secret_manager_secret_version" "github_token" {
  provider = google-beta

  count   = (var.github_token == "") ? 1 : 0
  project = var.github_token_gcp_project
  secret  = var.github_token_gcp_secret
}

provider "github" {
  token        = (var.github_token != "") ? var.github_token : data.google_secret_manager_secret_version.github_token[0].secret_data
  organization = var.github_organization
}

data "github_actions_public_key" "repo_key" {
  for_each = var.create_secret ? toset(var.repositories) : toset([])

  repository = each.key
}

resource "github_actions_secret" "gcloud_secret" {
  for_each = var.create_secret ? toset(var.repositories) : toset([])

  repository      = each.key
  secret_name     = var.secret_name
  plaintext_value = var.secret_value
}

data "github_dependabot_public_key" "repo_key_dependabot" {
  for_each = var.create_secret ? toset(var.repositories) : toset([])

  repository = each.key
}

resource "github_dependabot_secret" "gcloud_secret_dependabot" {
  for_each = var.create_secret ? toset(var.repositories) : toset([])

  repository      = each.key
  secret_name     = var.secret_name
  plaintext_value = var.secret_value
}
