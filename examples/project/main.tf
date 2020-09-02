module project {
  source = "../../"

  activate_apis   = ["container.googleapis.com"]
  billing_account = "013BF4-8DD1CF-A177EA"
  bucket_name     = "test-project-bucket-randomid"
  domain          = "extendaretail.com"
  folder_id       = "133650857832"
  name            = "test-project"
  org_id          = "478979796284"
  github_token    = "b67bf9c8d82642802b51413858d0907db0e5dda4"

  env_name           = "staging"
  service_group_name = "gcp-tribe1-test"
  clan_gsuite_group  = "group-clan1"

  services = [
    {
      name = "service1"
      iam_roles = [
        "roles/editor",
      ]
    }
  ]
}
