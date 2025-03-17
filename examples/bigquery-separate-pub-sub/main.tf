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
  region = "europe-west1"
}

module "pub" {
  source  = "terraform-google-modules/pubsub/google//modules/pub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = "cft-tf-pub-topic-bigquery"
  topic_labels = {
    foo_label = "foo_value"
    bar_label = "bar_value"
  }
}

module "sub" {
  source  = "terraform-google-modules/pubsub/google//modules/sub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = "cft-tf-pub-topic-bigquery"

  bigquery_subscriptions = [
    {
      name  = "sub_example_subscription"
      table = "${var.project_id}:sub_example_dataset.sub_example_table"
    },
  ]

  depends_on = [
    google_bigquery_table.test
  ]

}

resource "google_bigquery_dataset" "test" {
  project    = var.project_id
  dataset_id = "sub_example_dataset"
  location   = "europe-west1"
}

resource "google_bigquery_table" "test" {
  project             = var.project_id
  deletion_protection = false
  table_id            = "sub_example_table"
  dataset_id          = google_bigquery_dataset.test.dataset_id

  schema = <<EOF
[
  {
    "name": "data",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The data"
  }
]
EOF
}
