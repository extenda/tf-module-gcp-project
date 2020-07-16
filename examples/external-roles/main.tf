module "external-roles" {
  source = "../../modules/external-roles"

  roles_map = {
    "terraform@tf-root-project.iam.gserviceaccount.com" = {
      "ecosystem-staging-ec90" = [
        "role/editor",
      ],
      "ecosystem-cnp-staging-e1f7" = [
        "roles/compute.admin",
      ]
    }
  }
}
