module service-account {
  source = "../modules/service-account"

  create_service_account = true
  display_name = "Service Account"
  # iam_roles = {
  #   r0 = "roles/storage.admin", 
  #   r1 = "roles/run.admin"
  # }
  project_id = "project-test-id"

services = [
  {
    name = "my-service-1"
    iam_roles = { 
      r0 = "roles/storage.admin"
      r1 = "roles/run.admin"
  }
  },
  {
    name = "my-service-2"
    iam_roles = { 
      r0 = "roles/storage.admin"
      r1 = "roles/run.admin"
  }
  }
]
}