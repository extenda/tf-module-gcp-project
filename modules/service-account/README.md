## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| create\_service\_account | If this Service Account should be created | `bool` | n/a | yes |
| project\_id | Project ID where we will create the service accounts | `any` | n/a | yes |
| service_accounts | Map of IAM Roles to assign to the Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| email | The service account emails |
| private\_key | The service account JSON keys |
| private\_key\_encoded | The base64 encoded service account JSON keys |
