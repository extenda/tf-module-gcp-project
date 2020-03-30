## Providers

| Name   | Version   |
|:-------|:----------|
| google | ~> 2.7    |
| gsuite | ~> 0.1.35 |

GSuite Provider must be manually downloaded and installed in `$HOME/.terraform.d/plugins`. See GSuite Provider GitHub Repo for [Installation instructions](https://github.com/DeviaVir/terraform-provider-gsuite#installation).

For GSuite Group creation you must use a Service Account which is granted GSuite Domain Wide Delegation to impersonate the account specified in the `impersonated_user_email` variable. See GSuite Provider GitHub Repo for [details](https://github.com/DeviaVir/terraform-provider-gsuite#using-a-service-account)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| clan\_gsuite\_group | The name of the clan group that needs to be added to the Service GSuite Group | `string` | n/a | yes |
| create\_service\_account | If this Service Account should be created | `bool` | n/a | yes |
| create\_service\_group | If the Service GSuite Group should be created | `bool` | n/a | yes |
| domain | Domain name of the Organization | `string` | n/a | yes |
| impersonated\_user\_email | Email account of GSuite Admin user to impersonate for creating GSuite Groups. If not provided, will default to `terraform@<var.domain>` | `string` | `""` | no |
| project\_id | Project ID where we will create the service accounts | `any` | n/a | yes |
| services | Map of IAM Roles to assign to the Services Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | n/a | yes |
| service\_group\_name | The name of the group that will be created for services | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| email | The service account emails |
| private\_key | The service account JSON keys |
| private\_key\_encoded | The base64 encoded service account JSON keys |
