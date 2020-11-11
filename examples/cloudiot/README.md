# Cloud IoT Example

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name for the Cloud IoT registry | string | n/a | yes |
| project\_id | The project ID to manage the Pub/Sub resources | string | n/a | yes |
| region | The region for the IoT resources | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | The project ID |
| region | The region for the IoT resources |
| registry\_name | The name of the Pub/Sub topic created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

The following sections describe the requirements which must be met in
order to invoke this example. The requirements of the
[cloudiot module](../../modules/cloudiot) must be met.

## Usage

To provision this example, populate `terraform.tfvars` with the [required variables](#inputs) and run the following commands within
this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
