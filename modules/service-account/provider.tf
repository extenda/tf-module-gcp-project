provider "gsuite" {
  impersonated_user_email = local.impersonated_user_email

  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.group.member"
  ]

  version = "~> 0.1.35"
}

provider "google" {
  version = "~> 2.7"
  region  = "europe-west-1"
}
