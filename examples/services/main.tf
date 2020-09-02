module service-account {
  source                 = "../../modules/services"
  project_id             = "project-test-id"
  create_service_account = true
  create_service_group   = true
  service_group_name     = "clan1-tribe1-staging"
  clan_gsuite_group      = "tribe-tribe1-clan1"
  domain                 = "extenda.io"
  env_name               = "staging"

  services = [
    {
      name = "my-service-1"
      iam_roles = [
        "roles/storage.admin",
        "roles/run.admin"
      ]
    },
    {
      name = "my-service-2"
      iam_roles = [
        "roles/run.admin"
      ]
    }
  ]
}
