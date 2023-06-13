This module creates GCP part of workload-identity mapping between GCP service account and K8S service account, as well as other GKE-related resources.
For each service Kubernetes service account must be created with next parameters:

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: workload-service-account"
  namespace: {{service.nane}}
  annotations:
    iam.gke.io/gcp-service-account: {{service.name}}@{{project_id}}.iam.gserviceaccount.com
```

## Providers

| Name | Version |
|------|---------|
| kubernetes | 2.13.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| project\_id | ID of the project handling service accounts | `string` | n/a | yes |
| cluster\_project\_id | ID of the project with Kubernetes cluster | `string` | n/a | yes |
| services | List of services to setup namespace for | <pre>list(object({<br>    name      = string<br>  }))<br></pre> | n/a | yes |
| gke\_host | Kubernetes endpoint | `string` | n/a | yes |
| gke\_ca\_certificate | Kubernetes certificate | `string` | n/a | yes |
| cicd\_service | ci-cd-pipeline service account email | `string` | n/a | yes |
| ksa\_name | The name of Kubernetes Service Account to bind workload for | `string` | "workload-identity-sa" | no |
| project\_type | Project type this is applied to | `string` | `"clan_project"` | no |

## Outputs

No output.