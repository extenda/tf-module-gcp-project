This module is intended to create specific IAM roles in specific projects for the existing service account.

The module accepts a list of service accounts, projects and roles. The following data structure is passed to roles_map variable:

```
service-account1@project_id.iam.gserviceaccount.com:
  external_project1_id :
    - roles/role1
    - roles/role2
  external_project2_id :
    - roles/role3
    - roles/role4
service-account2@project_id.iam.gserviceaccount.com:
  external_project3_id :
    - roles/role5
    - roles/role6
```

See [example](../../examples/external-roles) of using the module

If `project_id` variable provided then only service name may be passed to map instead of whole service account:

```
service1:
  external_project1_id :
    - roles/role1
    - roles/role2
  external_project2_id :
    - roles/role3
    - roles/role4
```



## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| roles\_map | Nested map of service accounts to projects to list of roles | `map(map(list(string)))` | n/a | yes |
| project\_id | Project ID of service account if service name passed only | `string` | `""` | no |
| sa\_depends\_on | Service Account which this module depends on | `any` | "" | no |

## Outputs

No output.
