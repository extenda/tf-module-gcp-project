# Workload-identity

This module creates GCP part of workload-identity mapping between GCP service account and K8S service account.

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

If `cluster_project_id` variable is empty than module does nothing.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| project\_id | ID of the project handling service accounts | `string` | n/a | yes |
| cluster\_project\_id | ID of the project with kubernetes cluster | `string` | n/a | yes |
| services | List of services with IAM Roles to assign to the Services Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | n/a | yes |
| ksa\_name | The name of Kubernetes Service Account to bind workload for | `string` | `"default"` | no |

## Outputs

No output