/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "pub" {
  source  = "terraform-google-modules/pubsub/google//modules/pub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = "cft-tf-pub-topic-cr-push"
  topic_labels = {
    foo_label = "foo_value"
    bar_label = "bar_value"
  }
}

module "sub" {
  source  = "terraform-google-modules/pubsub/google//modules/sub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = module.pub.topic

  push_subscriptions = [
    {
      name                       = module.cloud-run.service_name
      push_endpoint              = module.cloud-run.service_uri
      oidc_service_account_email = module.cloud-run.service_account_id.email
    },
  ]
}

module "cloud-run" {
  source                        = "GoogleCloudPlatform/cloud-run/google//modules/v2"
  version                       = "~> 0.17"
  project_id                    = var.project_id
  location                      = "us-central1"
  service_name                  = "cr-service"
  containers                    = [{ "container_name" = "", "container_image" = "gcr.io/design-center-container-repo/pubsub-cr-push:latest-1703" }]
  service_account_project_roles = ["roles/run.invoker"]
  members                       = ["allUsers"]
  cloud_run_deletion_protection = false
}
