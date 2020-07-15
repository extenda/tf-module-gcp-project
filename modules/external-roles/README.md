This module is for creating specific iam roles in specific projects for existing service account.

Module accept a list of service accounts, projects and roles in next data structure passed to roles_map variable:

```
service-account@project_id.iam.gserviceaccount.com:
  external_project1_id :
    - roles/role1
    - roles/role2
  external_project2_id :
    - roles/role3
    - roles/role4
```

See [example](../../examples/external-roles) of using the module

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| roles_map | Nested map of service accounts to projects to list of roles | `map(map(list(string)))` | n/a | yes |
| sa\_depends\_on | Service Account which this module depends on | `any` | n/a | no |

## Outputs

No output.
