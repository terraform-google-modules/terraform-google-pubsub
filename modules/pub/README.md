# terraform-google-pubsub

This module makes it easy to create Google Cloud Pub/Sub topic.

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.9.0](https://registry.terraform.io/modules/terraform-google-modules/-pubsub/google/v1.9.0).

## Usage

This is a simple usage of the module. Please see also a simple setup provided in the example directory.

```hcl
module "pub" {
  source  = "terraform-google-modules/pubsub/google//modules/pub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = "cft-tf-pub-topic"
  topic_labels = {
    foo_label = "foo_value"
    bar_label = "bar_value"
  }

  schema = {
    name       = "pub-example"
    type       = "AVRO"
    encoding   = "JSON"
    definition = "{\n  \"type\" : \"record\",\n  \"name\" : \"Avro\",\n  \"fields\" : [\n    {\n      \"name\" : \"StringField\",\n      \"type\" : \"string\"\n    },\n    {\n      \"name\" : \"IntField\",\n      \"type\" : \"int\"\n    }\n  ]\n}\n"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| message\_storage\_policy | A map of storage policies. Default - inherit from organization's Resource Location Restriction policy. | `map(any)` | `{}` | no |
| project\_id | The project ID to manage the Pub/Sub resources. | `string` | n/a | yes |
| schema | Schema for the topic. | <pre>object({<br>    name       = string<br>    type       = string<br>    definition = string<br>    encoding   = string<br>  })</pre> | `null` | no |
| topic | The Pub/Sub topic name. | `string` | n/a | yes |
| topic\_kms\_key\_name | The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic. | `string` | `null` | no |
| topic\_labels | A map of labels to assign to the Pub/Sub topic. | `map(string)` | `{}` | no |
| topic\_message\_retention\_duration | The minimum duration in seconds to retain a message after it is published to the topic. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Pub/Sub topic |
| topic | The name of the Pub/Sub topic |
| topic\_labels | Labels assigned to the Pub/Sub topic |
| uri | The URI of the Pub/Sub topic |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

### Installation Dependencies

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin >= v2.13

### Configure a Service Account

In order to execute this module you must have a Service Account with the following:

#### Roles

- `roles/pubsub.admin`

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud Pub/Sub API

#### Service Account Credentials

You can pass the service account credentials into this module by setting the following environment variables:

* `GOOGLE_CREDENTIALS`
* `GOOGLE_CLOUD_KEYFILE_JSON`
* `GCLOUD_KEYFILE_JSON`

See more [details](https://www.terraform.io/docs/providers/google/provider_reference.html#configuration-reference).

[v0.2.0]: https://registry.terraform.io/modules/terraform-google-modules/pubsub/google/0.2.0
[terraform-0.12-upgrade]: https://www.terraform.io/upgrade-guides/0-12.html
