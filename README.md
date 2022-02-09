# terraform-google-pubsub

This module makes it easy to create Google Cloud Pub/Sub topic and subscriptions associated with the topic.

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.9.0](https://registry.terraform.io/modules/terraform-google-modules/-pubsub/google/v1.9.0).

## Usage

This is a simple usage of the module. Please see also a simple setup provided in the example directory.

```hcl
module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic      = "tf-topic"
  project_id = "my-pubsub-project"
  push_subscriptions = [
    {
      name                       = "push"                                               // required
      ack_deadline_seconds       = 20                                                   // optional
      push_endpoint              = "https://example.com"                                // required
      x-goog-version             = "v1beta1"                                            // optional
      oidc_service_account_email = "sa@example.com"                                     // optional
      audience                   = "example"                                            // optional
      expiration_policy          = "1209600s"                                           // optional
      dead_letter_topic          = "projects/my-pubsub-project/topics/example-dl-topic" // optional
      max_delivery_attempts      = 5                                                    // optional
      maximum_backoff            = "600s"                                               // optional
      minimum_backoff            = "300s"                                               // optional
      filter                     = "attributes.domain = \"com\""                        // optional
      enable_message_ordering    = true                                                 // optional
    }
  ]
  pull_subscriptions = [
    {
      name                    = "pull"                                               // required
      ack_deadline_seconds    = 20                                                   // optional
      dead_letter_topic       = "projects/my-pubsub-project/topics/example-dl-topic" // optional
      max_delivery_attempts   = 5                                                    // optional
      maximum_backoff         = "600s"                                               // optional
      minimum_backoff         = "300s"                                               // optional
      filter                  = "attributes.domain = \"com\""                        // optional
      enable_message_ordering = true                                                 // optional
      service_account         = "service2@project2.iam.gserviceaccount.com"          // optional
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_subscriptions | Specify true if you want to create subscriptions | `bool` | `true` | no |
| create\_topic | Specify true if you want to create a topic | `bool` | `true` | no |
| grant\_token\_creator | Specify true if you want to add token creator role to the default Pub/Sub SA | `bool` | `true` | no |
| message\_storage\_policy | A map of storage policies. Default - inherit from organization's Resource Location Restriction policy. | `map(any)` | `{}` | no |
| project\_id | The project ID to manage the Pub/Sub resources | `string` | n/a | yes |
| pull\_subscriptions | The list of the pull subscriptions | `list(map(string))` | `[]` | no |
| push\_subscriptions | The list of the push subscriptions | `list(map(string))` | `[]` | no |
| schema | Schema for the topic | <pre>object({<br>    name       = string<br>    type       = string<br>    definition = string<br>    encoding   = string<br>  })</pre> | `null` | no |
| subscription\_labels | A map of labels to assign to every Pub/Sub subscription | `map(string)` | `{}` | no |
| topic | The Pub/Sub topic name | `string` | n/a | yes |
| topic\_kms\_key\_name | The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic. | `string` | `null` | no |
| topic\_labels | A map of labels to assign to the Pub/Sub topic | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Pub/Sub topic |
| subscription\_names | The name list of Pub/Sub subscriptions |
| subscription\_paths | The path list of Pub/Sub subscriptions |
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
