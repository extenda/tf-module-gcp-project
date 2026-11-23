# Migrating from v1.x to v2.0

`tf-module-gcp-project` v2.0.0 upgrades the module to Google provider 8.x and
[terraform-google-project-factory](https://github.com/terraform-google-modules/terraform-google-project-factory/) 18.4.0
(from 10.1.0 on Google provider 3.x).

## What changed

| | v1.9.0 | v2.0.0 |
|:--|:--|:--|
| project-factory | 10.1.0 | 18.4.0 |
| google / google-beta | `~> 3.8` | `>= 6.0, < 9` |
| Terraform | >= 0.12.18 | >= 1.3 (required by project-factory 18.x) |
| Secret Manager replication | `automatic = true` | `auto {}` |

The module's own inputs and outputs are unchanged. The following project-factory
changes also apply:

- **State bucket keeps uniform bucket-level access off.** project-factory enables
  it by default since v11; this module sets `bucket_ula = false` to keep existing
  state buckets as they are.
- **Projects get `deletion_policy = "PREVENT"`** (project-factory default since v17).
  A `terragrunt destroy` of the project fails until the policy is changed to `DELETE`.
- **Shared VPC network roles** are controlled by project-factory's `grant_network_role`
  (renamed from `grant_services_network_role` in v13). This module doesn't set it,
  so the default (`true`) applies.

> [!WARNING]
> State written by v2.0.0 can't be read by Google provider 3.x. Once a project has
> been applied with v2.0.0, rolling back to v1.x means restoring the state file.

## Before you start

1. The project should be on **v1.9.0** with a clean plan. v1.9.0 is the release with
   the `googleworkspace` provider; see [MIGRATION_new_gsuite_provider.md](MIGRATION_new_gsuite_provider.md)
   if you're coming from an older version.
2. Back up the state:

   ```bash
   terragrunt state pull > state-$(date +%Y%m%d).json
   ```

3. Check for broken `googleworkspace_group_member` entries. If the plan shows group
   members with an id ending in `/members/` (no email), or refresh fails with a
   `googleapi: ... 404`, fix those first: `terragrunt state rm` the address, then
   import it again with the service account's numeric `uniqueId`:

   ```bash
   terragrunt state rm 'module.services_sa.googleworkspace_group_member.clan_group_member["<sa>"]'
   terragrunt import 'module.services_sa.googleworkspace_group_member.clan_group_member["<sa>"]' \
     "groups/<group>@extendaretail.com/members/$(gcloud iam service-accounts describe <sa-email> --format='value(uniqueId)')"
   ```

## Upgrade

1. Bump the module ref in the project's `terragrunt.hcl`:

   ```diff
    terraform {
   -  source = "git::https://github.com/extenda/tf-module-gcp-project//?ref=v1.9.0"
   +  source = "git::https://github.com/extenda/tf-module-gcp-project//?ref=v2.0.0"
    }
   ```

2. If the project has GKE resources from `modules/gke-resources`, pin them to the
   module's own tag instead of the main release tag:

   ```diff
   -  source = "git::https://github.com/extenda/tf-module-gcp-project//modules/gke-resources?ref=v2.0.0"
   +  source = "git::https://github.com/extenda/tf-module-gcp-project//modules/gke-resources?ref=gke-resources-v1.0.0"
   ```

3. Re-initialize so the new providers are downloaded and the lock file is updated:

   ```bash
   terragrunt init -upgrade
   ```

4. Plan, and review it before applying:

   ```bash
   terragrunt plan
   ```

   Expect only in-place updates. **Stop if the plan wants to replace or destroy**
   `google_project`, the state bucket, service accounts or Secret Manager secrets.

5. Apply:

   ```bash
   terragrunt apply
   ```

6. Run `terragrunt plan` again to confirm it's clean.

## Shared VPC

The `shared_vpc` and `shared_vpc_subnets` inputs still work in v2.0.0. Projects
that no longer use the tribe's shared VPC can remove them, along with the
`tribe_network` dependency:

```diff
-dependency "tribe_network" {
-  config_path = "../../../resources/${local.env_name}/network"
-  ...
-}
 ...
-    shared_vpc = dependency.tribe_project.outputs.project_id
-    shared_vpc_subnets = [
-      dependency.tribe_network.outputs.subnets["europe-west1/clan-resources"].id
-    ]
```

This detaches the project from the host project and removes its subnet IAM
bindings. Check that nothing in the project (GKE, Serverless VPC Access, etc.)
still uses the shared subnets before applying.
