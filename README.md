# tf-module-gcp-project

<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" height="100px">

## Description

An Extenda Retail maintained Terraform Module, which is intended to create specific Project resources within the Google Cloud Platform and GSuite. It creates projects and configures aspects like Service Accounts, IAM access, API enablement, Workload Identity, GitHub Secrets.

## Providers

| Name   | Version   |
|:-------|:----------|
| google | ~> 3.8    |
| gsuite | ~> 0.1.35 |

GSuite Provider must be manually downloaded and installed in `$HOME/.terraform.d/plugins`. See GSuite Provider GitHub Repo for [Installation instructions](https://github.com/DeviaVir/terraform-provider-gsuite#installation).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| activate\_apis | The list of apis to activate within the project | `list(string)` | n/a | yes |
| additional\_user\_access | List of IAM Roles to assign to groups and users | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>    members   = list(string)<br>  }))</pre> | `[]` | no |
| billing\_account | The ID of the billing account to associate this project with | `any` | n/a | yes |
| bucket\_name | The name of the bucket that will contain terraform state - must be globally unique | `any` | n/a | yes |
| ci\_cd\_sa | Map of IAM Roles to assign to the CI/CD Pipeline Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "iam_roles": [<br>      "roles/cloudsql.editor",<br>      "roles/iam.serviceAccountUser",<br>      "roles/run.admin",<br>      "roles/storage.admin",<br>      "roles/cloudfunctions.admin",<br>      "roles/secretmanager.secretAccessor",<br>      "roles/dataflow.admin",<br>      "roles/bigquery.admin"<br>    ],<br>    "name": "ci-cd-pipeline"<br>  }<br>]</pre> | no |
| clan\_gsuite\_group | The name of the clan group that needs to be added to the Service GSuite Group | `string` | `""` | no |
| clan\_roles | Roles to be added to the clan's group in the staging project | `list(string)` | `[]` | no |
| cloudrun\_sa | Map of IAM Roles to assign to the CloudRun Runtime Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "iam_roles": [<br>      "roles/editor",<br>      "roles/secretmanager.secretAccessor"<br>    ],<br>    "name": "cloudrun-runtime"<br>  }<br>]</pre> | no |
| common\_iam\_roles | Default list of IAM Roles to assign to every Services Service Account | `list(string)` | <pre>[<br>  "roles/monitoring.metricWriter",<br>  "roles/logging.logWriter",<br>  "roles/monitoring.viewer",<br>  "roles/cloudtrace.agent",<br>  "roles/secretmanager.secretAccessor"<br>]</pre> | no |
| create\_ci\_cd\_group | If the Service GSuite Group should be created for the CI/CD Service Account | `bool` | `false` | no |
| create\_ci\_cd\_service\_account | If the CI/CD Service Account should be created | `bool` | `true` | no |
| create\_cloudrun\_group | If the Service GSuite Group should be created for the CloudRun Runtime Service Account | `bool` | `false` | no |
| create\_cloudrun\_service\_account | If the CloudRun Runtime Service Account should be created | `bool` | `true` | no |
| create\_custom\_roles | If the Custom Roles from the additioanl-use-access submodule should be created | `bool` | `true` | no |
| create\_jit\_access | If the eligible roles should be created | `bool` | `false` | no |
| create\_pact\_secrets | If the pact-broker secrets should be created | `bool` | `false` | no |
| create\_sa | If the Service Account should be created | `bool` | `true` | no |
| create\_secret\_manager\_group | If the Service GSuite Group should be created for the Secret Manager Access Service Account | `bool` | `false` | no |
| create\_secret\_manager\_service\_account | If the Secret Manager Access Service Account should be created | `bool` | `false` | no |
| create\_service\_sa | If the Service Account for new Services should be created | `bool` | `true` | no |
| create\_services\_group | If the Service GSuite Group should be created for the Services (services variable) | `bool` | `true` | no |
| credentials | JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fallback to GOOGLE\_APPLICATION\_CREDENTIALS env variable. | `any` | `null` | no |
| custom\_external\_roles | Map of service or service account to external projects to list of iam roles for add | `map(map(list(string)))` | `{}` | no |
| default\_service\_account | Project default service account setting: can be one of delete, deprivilege, disable, or keep. | `string` | `"deprivilege"` | no |
| dns\_project\_iam\_roles | List of IAM Roles to add to DNS project | `list(string)` | <pre>[<br>  "roles/dns.admin"<br>]</pre> | no |
| dns\_project\_id | ID of the project hosting Google Cloud DNS | `string` | `""` | no |
| domain | Domain name of the Organization | `string` | n/a | yes |
| env\_name | Environment name (staging/prod). Creation of some resources depends on env\_name | `string` | `""` | no |
| folder\_id | The ID of a folder to host this project | `any` | n/a | yes |
| gcr\_project\_iam\_roles | List of IAM Roles to add GCR project | `list(string)` | <pre>[<br>  "roles/storage.admin"<br>]</pre> | no |
| gcr\_project\_id | ID of the project hosting Google Container Registry | `string` | `""` | no |
| github\_organization | GitHub organization to use GitHub prodifer with | `string` | `"extenda"` | no |
| github\_token | GitHub token value (instead request GCP secret) | `string` | `""` | no |
| github\_token\_gcp\_project | GCP project that contains Secret Manager for Github token | `string` | `"tf-admin-90301274"` | no |
| github\_token\_gcp\_secret | SGP secret name for GitHub token | `string` | `"github-token"` | no |
| gke\_ca\_certificate | Kubernetes certificate | `string` | `""` | no |
| gke\_host | Kubernetes endpoint | `string` | `"no-gke-host"` | no |
| impersonated\_user\_email | Email account of GSuite Admin user to impersonate for creating GSuite Groups. If not provided, will default to `terraform@<var.domain>` | `string` | `""` | no |
| jit\_access | Map of IAM Roles to assign to the group | <pre>list(object({<br>    group      = string<br>    iam_roles = list(string)<br>  }))</pre> | `[]` | no |
| labels | Map of labels for the project | `map(string)` | `{}` | no |
| name | The name for the project | `any` | n/a | yes |
| org\_id | The organization ID | `any` | n/a | yes |
| pact\_project\_id | GCP project that contains secrets for pact-broker | `string` | `"platform-prod-2481"` | no |
| pactbroker\_pass\_secret | GCP secret name for pact-broker password | `string` | `"pactbroker_password"` | no |
| pactbroker\_user\_secret | GCP secret name for pact-broker user | `string` | `"pactbroker_username"` | no |
| parent\_project\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | <pre>[<br>  "roles/monitoring.admin",<br>  "roles/iam.serviceAccountUser"<br>]</pre> | no |
| pipeline\_project\_id | GCP project that contains secrets for slack notify token | `string` | `pipeline-secrets-1136` | no |
| parent\_project\_id | ID of the project to which add additional IAM roles for current project's CI/CD service account. Ignore if empty | `string` | `""` | no |
| project\_type | what type of project this is applied to | `string` | `"clan_project"` | no |
| random\_project\_id | Adds a suffix of 4 random characters to the project\_id | `bool` | `true` | no |
| repositories | The GitHub repositories to update | `list(string)` | `[]` | no |
| secret\_manager\_sa | Map of IAM Roles to assign to the Secret Manager Access Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "iam_roles": [<br>      "roles/secretmanager.secretAccessor"<br>    ],<br>    "name": "secret-accessor"<br>  }<br>]</pre> | no |
| service\_accounts | Map of IAM Roles to assign to the Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))</pre> | `[]` | no |
| service\_group\_name | The name of the group that will be created for a service | `string` | `""` | no |
| services | Map of IAM Roles to assign to the Services Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))</pre> | `[]` | no |
| shared\_vpc | The ID of the host project which hosts the shared VPC | `string` | `""` | no |
| shared\_vpc\_subnets | List of subnets fully qualified subnet IDs (ie. projects/$project\_id/regions/$region/subnetworks/$subnet\_id) | `list(string)` | `[]` | no |
| slack\_notify\_secret | GCP secret name for slack token | `string` | `slack-notify-token` | no |

## Outputs

| Name | Description |
|------|-------------|
| ci\_cd\_service\_account\_email | The CI/CD pipeline service account email |
| ci\_cd\_service\_account\_private\_key\_encoded | The CI/CD pipeline service account base64 encoded JSON key |
| cloudrun\_service\_account\_email | The Cloud Run service account email |
| enabled\_apis | Enabled APIs in the project |
| gsuite\_group\_email | The GSuite group emails created per each service |
| project\_id | The project ID |
| project\_name | The project name |
| project\_number | The project number |
| secret\_manager\_service\_account\_private\_key\_encoded | The Cloud Run service account base64 encoded JSON key |
| service\_account\_email | The default service acccount email |
| service\_account\_private\_keys\_encoded | Service accounts base64 encoded JSON keys |
| service\_emails | Services service account emails |
| service\_private\_keys\_encoded | The Services service account base64 encoded JSON key |
| terraform\_state\_bucket | Bucket for saving terraform state of project resources |
