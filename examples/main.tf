module service-account {
  source                 = "../modules/service-account"
  project_id             = "project-test-id"
  create_service_account = true
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
