# Upgrading to v0.4.0
The v0.4.0 release of _service_account_ module is a backwards incompatible release.

Because v0.4.0 changed how the service account is creating and getting roles assigned to it (using for_each), resources in Terragrunt state need to be migrated in order to avoid the resources from getting destroyed and recreated.

## Migration Instructions
First, upgrade to the new version of this module.

```diff
terraform {
- source = "github.com/extenda/tf-module-gcp-project//modules/project?ref=v0.3.2"
+ source = "github.com/extenda/tf-module-gcp-project//modules/project?ref=v0.4.0"
}
```
If you run `terragrunt plan` at this point, Terragrunt will inform you that it will attempt to delete and recreate your existing service_acounts and keys. This is almost certainly not the behavior you want.

You will need to migrate your state.

### Migration Script

1.  Download the script:

    ```sh
    curl -O https://raw.githubusercontent.com/extenda/tf-module-gcp-project/master/docs/migration_v0.3.2_v0.4.0.sh
    chmod +x migration_v0.3.2_v0.4.0.sh
    ```
2.  Back up your Terraform state:

    ```sh
    terraform state pull >> state.json
    ```
3. Execute the migration script:

```sh
    $ ./migration_v0.3.2_v0.4.0.sh
    Moving module.ci_cd_sa.google_service_account.sa[0]..
    Moving module.ci_cd_sa.google_project_iam_member.project["r0"]..
    Moving module.ci_cd_sa.google_project_iam_member.project["r1"]..
    Moving module.ci_cd_sa.google_project_iam_member.project["r2"]..
    Moving module.ci_cd_sa.google_service_account_key.key_json[0]..
    Moving module.cloudrun_sa.google_service_account.sa[0]..
    Moving module.cloudrun_sa.google_project_iam_member.project["r0"]..
    Moving module.cloudrun_sa.google_project_iam_member.project["r1"]..
    Moving module.cloudrun_sa.google_service_account_key.key_json[0]..
    9 resources has been moved
    Pulling tfstate file into tfstate.json..
    Patching local state file..
    Pushing tfstate file from tfstate2.json..
```

4.  Run `terragrunt plan` to confirm no destroys are expected. You will see the `display_name` changes (`~ update in-place`) as the logic of its assignment was changed in the module. It won't affect your service_accounts or keys.
```sh 
    Resource actions are indicated with the following symbols:
    ~ update in-place

    Terraform will perform the following actions:

    # module.ci_cd.google_service_account.sa["0"] will be updated in-place
    ~ resource "google_service_account" "sa" {
            account_id   = "ci-cd-pipeline"
        ~ display_name = "CI/CD Service Account" -> "ci-cd-pipeline Service Account"
            ...
        }

    # module.cloudrun.google_service_account.sa["0"] will be updated in-place
    ~ resource "google_service_account" "sa" {
            account_id   = "cloudrun-runtime"
        ~ display_name = "Cloud Run Runtime Service Account" -> "cloudrun-runtime Service Account"
            ...
        }

    Plan: 0 to add, 2 to change, 0 to destroy.
```
This means that Terragrunt did not detect any other differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed, except display_name changing.

5. Run `terragrunt apply` to apply two `display_name` changes.
6. Delete all the created .json files.