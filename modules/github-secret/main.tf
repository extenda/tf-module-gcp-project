# This requires google-beta v3.8 and we're stuck on v2.
# How can we fetch this token instead? Berglas? Using local-exec
# data "google_secret_manager_secret_version" "github_token" {
#   provider = google-beta
#
#   project  = "pipeline-secrets-1136"
#   secret   = "github-token"
# }

data "external" "github_token" {
  program = ["bash", "${path.module}/github_token.sh"]
}

provider "github" {
  version      = "~> 2.0"
  #token        = data.github_token.secret_data
  token = data.external.github_token.result["token"]
  organization = var.github_organization
}

// How to for loop a data block?

data "github_actions_public_key" "repo_key" {
  for_each = var.secret_value != "" ? toset(var.repositories) : toset([])

  repository = each.key
}

resource "github_actions_secret" "gcloud_secret" {
  for_each = var.secret_value != "" ? toset(var.repositories) : toset([])

  repository      = each.key
  secret_name     = var.secret_name
  plaintext_value = var.secret_value
}
