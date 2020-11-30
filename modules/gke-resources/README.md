## Providers

| Name | Version |
|------|---------|
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| project\_id | ID of the project handling service accounts | `string` | n/a | yes |
| cluster\_project\_id | ID of the project with kubernetes cluster | `string` | n/a | yes |
| services | List of services to setup namespace for | <pre>list(object({<br>    name      = string<br>  }))<br></pre> | n/a | yes |
| gke_host | Kubernetes endpoint | `string` | n/a | yes |
| gke_ca_certificate | Kubernetes certificate | `string` | n/a | yes |
| cicd_service | cicd pipeline service account | `string` | n/a | yes |
| sa\_depends\_on | Service Account which this module depends on | `any` | n/a | yes |

## Outputs

No output.
