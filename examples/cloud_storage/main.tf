/**
 * Copyright 2018-2023 Google LLC
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

resource "random_id" "bucket_suffix" {
  count       = var.random_bucket_suffix ? 1 : 0
  byte_length = 4
}

provider "google" {
  region = "europe-west1"
}

module "pubsub" {
  source     = "../../"
  project_id = var.project_id
  topic      = "cft-tf-pubsub-topic-cloud-storage"

  cloud_storage_subscriptions = [
    {
      name   = "example_subscription"
      bucket = google_storage_bucket.test.name
    },
  ]
}

resource "google_storage_bucket" "test" {
  project  = var.project_id
  name     = var.random_bucket_suffix ? join("-", [var.bucket_name, random_id.bucket_suffix[0].id]) : var.bucket_name
  location = "europe-west1"
}
