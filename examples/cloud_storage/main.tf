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

module "pubsub" {
  source     = "../../"
  project_id = var.project_id
  topic      = "tf-pub-sub-topic-cloud-storage"
  topic_labels = {
    foo_label = "foo_value"
    bar_label = "bar_value"
  }

  cloud_storage_subscriptions = [
    {
      name            = "cloud_storage"
      bucket          = google_storage_bucket.bucket-test[0].name
      filename_prefix = "test-"
      filename_suffix = "-ps"
      max_duration    = "60s"
      max_bytes       = 1024
    }
  ]

  depends_on = [
    google_storage_bucket.bucket-test
  ]
}

resource "google_storage_bucket" "bucket-test" {
  name                        = "testps-bucket"
  location                    = "EU"
  uniform_bucket_level_access = true
  force_destroy               = true
}
