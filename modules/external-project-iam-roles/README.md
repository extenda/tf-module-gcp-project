## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| dns\_project\_iam\_roles | List of IAM Roles to add to DNS project | `list(string)` | n/a | yes |
| dns\_project\_id | ID of the project hosting Google Cloud DNS | `string` | n/a | yes |
| gcr\_project\_iam\_roles | List of IAM Roles to add GCR project | `list(string)` | n/a | yes |
| gcr\_project\_id | ID of the project hosting Google Container Registry | `string` | n/a | yes |
| gke\_gcr\_iam\_roles | List of IAM Roles to add to the GCR project | `list(string)` | n/a | yes |
| gke\_parent\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | n/a | yes |
| gke\_service\_account | GKE service account email that IAM roles will be added to | `string` | n/a | yes |
| parent\_project\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | n/a | yes |
| parent\_project\_id | ID of the project to which add additional IAM roles for current project's CI/CD service account. Don't add roles if value is empty | `string` | n/a | yes |
| service\_account | Service account email to add IAM roles in parent project for | `string` | n/a | yes |
| service\_account\_exists | If service_account for service exists or not | `bool` | n/a | yes |
| project\_id | Local (clan) Project ID where service account is created | `string` | n/a | yes |
| services | List of services with IAM roles | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | n/a | yes |
| common\_iam\_roles | List of IAM Roles to assign to every Services Service Account in Tribe project | `list(string)` | `[]` | no |
| sa\_depends\_on | Service Account which this module depends on | `any` | n/a | yes |


variable project_id {
  description = "Local (clan) Project ID where service account is created"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  description = "List of services with IAM roles"
}

variable common_iam_roles {
  description = "List of IAM Roles to assign to every Services Service Account in Tribe project"
  type        = list(string)
  default     = []
}

variable sa_depends_on {
  description = "Service Account which this module depends on"
  type        = any
}


## Outputs

No output.

