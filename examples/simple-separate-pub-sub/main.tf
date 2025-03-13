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

provider "google" {
  region = "us-central1"
}

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

module "sub" {
  source  = "terraform-google-modules/pubsub/google//modules/sub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = module.pub.topic

  pull_subscriptions = [
    {
      name                         = "sub-pull"
      ack_deadline_seconds         = 10
      enable_exactly_once_delivery = true
    },
    {
      name              = "sub-pull2"
      minimum_backoff   = "10s"
      maximum_backoff   = "600s"
      expiration_policy = "1209600s" // two weeks
    }
  ]

  push_subscriptions = [
    {
      name                 = "sub-push"
      push_endpoint        = "https://${var.project_id}.appspot.com/"
      x-goog-version       = "v1beta1"
      ack_deadline_seconds = 20
      expiration_policy    = "1209600s" // two weeks
    },
    {
      name           = "sub-push-default-expiration"
      push_endpoint  = "https://${var.project_id}.appspot.com/"
      x-goog-version = "v1beta1"
    },
  ]
}
