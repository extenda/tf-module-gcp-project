module service-account {
  source = "../modules/service-account"
  project_id = "project-test-id"
  names = ["service-acc1", "service-acc2"]
  project_roles = ["project-test-id=>role1", "project-test-id=>role2"]
}
