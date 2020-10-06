
`tf-module-gcp-project` v9.x is based on new major release of
[terraform-google-project-factory](https://github.com/terraform-google-modules/terraform-google-project-factory/) 9.x,
which has breaking changes but also compatible with Terraform 0.13

## Update to tf-module-gcp-project v9.x 

Next steps need to be applied to update to `tf-module-gcp-project` v9.x and Terraform 0.13.x:

1. Staying with Terraform 0.12 update `tf-module-gcp-project`  to v9.0 for tribe and clan projects

2. To not recreate shared vpc subnets in clan projects move terraform resources:
``` bash
terragrunt state mv module.project_factory.module.project-factory.google_compute_subnetwork_iam_member.gke_shared_vpc_subnets[0] \
  module.project_factory.module.shared_vpc_access.google_compute_subnetwork_iam_member.service_shared_vpc_subnet_users[0]

terragrunt state mv module.project_factory.module.project-factory.google_project_iam_member.gke_host_agent[0] \
  module.project_factory.module.shared_vpc_access.google_project_iam_member.gke_host_agent[0]
```

3. Run `terragrunt apply` to apply the changes of brought from 

4. Update to Terraform 0.13.4

5. Replace gsuite provider in state files for every project `tf-module-gcp-project` and `terraform-google-project-factory` modules

```bash
terragrunt state replace-provider -auto-approve registry.terraform.io/-/gsuite registry.terraform.io/deviavir/gsuite
```

6. Run `terragrunt plan` and `terragrunt apply` again to confirm all state and changes are in sync.

7. Profit
