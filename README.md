# terraform-google-pubsub

This module makes it easy to create Google Cloud Pub/Sub topic and subscriptions associated with the topic.

## Usage

This is a simple usage of the module. Please see also a simple setup provided in the example directory.

```hcl
module "pubsub" {
  source             = "github.com/terraform-google-modules/terraform-google-pubsub"
  topic              = "tf-topic"
  project_id         = "my-pubsub-project"
  push_subscriptions = [
    {
      name                 = "push"   // required
      ack_deadline_seconds = 20 // optional
      push_endpoint        = "https://example.com" // required
      x-goog-version       = "v1beta1" // optional
    }
  ]
  pull_subscriptions = [
    {
      name                 = "pull" // required
      ack_deadline_seconds = 20 // optional
    }
  ]
}
```

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project_id | The project ID to manage the Pub/Sub resources | string | - | yes |
| pull_subscriptions | The list of the pull subscriptions | list | `<list>` | no |
| push_subscriptions | The list of the push subscriptions | list | `<list>` | no |
| topic | The Pub/Sub topic name | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| subscription_names | The name list of Pub/Sub subscriptions |
| subscription_paths | The path list of Pub/Sub subscriptions |
| topic | The name of the Pub/Sub topic |

[^]: (autogen_docs_end)

## Requirements

### Installation Dependencies

- [terraform](https://www.terraform.io/downloads.html) 0.11.x
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v1.12.x

### Configure a Service Account

In order to execute this module you must have a Service Account with the following:

#### Roles

- `roles/pubsub.editor`

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud Pub/Sub API

#### Service Account Credentials

You can pass the service account credentials into this module by setting the following environment variables:

* `GOOGLE_CREDENTIALS`
* `GOOGLE_CLOUD_KEYFILE_JSON`
* `GCLOUD_KEYFILE_JSON`

See more [details](https://www.terraform.io/docs/providers/google/provider_reference.html#configuration-reference).

## Testing

### Requirements

- [bundler](https://bundler.io/)
- [ruby](https://www.ruby-lang.org/) 2.5.x
- [python](https://www.python.org/getit/) 2.7.x
- [terraform-docs](https://github.com/segmentio/terraform-docs) 0.4.5
- [google-cloud-sdk](https://cloud.google.com/sdk/)

### Generate docs automatically

```sh
$ make generate_docs
```

### Integration Test

The integration tests for this module leverage kitchen-terraform and kitchen-inspec.

You must set up by manually before running the integration test:

- Copy from `test/fixtures/terraform.tfvars.sample` to `test/fixtures/terraform.tfvars`.
- Modify values to match your environment.

The tests will do the following:

- Perform `bundle install` command
  - Installs `test-kitchen`, `kitchen-terraform` and `kitchen-inspec`
- Perform `bundle exec kitchen create` command
  - Performs `terraform init`
- Perform `bundle exec kitchen converge` command
  - Performs `terraform apply -auto-approve`
- Perform `bundle exec kitchen verify` command
  - Performs inspec tests
- Perform `bundle exec kitchen destroy` command
  - Performs `terraform destroy -force`

You can use the following command to run the integration test in the root directory.

```sh
$ make test_integration
```

## Linting

The makefile in this project will lint or sometimes just format any shell, Python, golang, Terraform, or Dockerfiles. The linters will only be run if the makefile finds files with the appropriate file extension.

All of the linter checks are in the default make target, so you just have to run

```sh
$ make -s
```

The -s is for 'silent'. Successful output looks like this

```
Running shellcheck
Running flake8
Running go fmt and go vet
Running terraform validate
Running terraform fmt
Running hadolint on Dockerfiles
Checking for required files
The following lines have trailing whitespace
Generating markdown docs with terraform-docs
```

The linters
are as follows:
- Shell - shellcheck. Can be found in homebrew
- Python - flake8. Can be installed with `pip install flake8`
- Golang - gofmt. gofmt comes with the standard golang installation. golang
-s a compiled language so there is no standard linter.
- Terraform - terraform has a built-in linter in the `terraform validate` command.
- Dockerfiles - hadolint. Can be found in homebrew
