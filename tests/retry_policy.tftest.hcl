# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Plan-only checks with a mocked provider (no GCP access needed):
#   terraform init -backend=false && terraform test

mock_provider "google" {}
variables {
  project_id = "p"
  topic      = "t"
}
run "min_only_push" {
  command = plan
  variables {
    push_subscriptions          = [{ name = "push", push_endpoint = "https://example.com", minimum_backoff = "20s" }]
    pull_subscriptions          = [{ name = "pull", minimum_backoff = "20s" }]
    bigquery_subscriptions      = [{ name = "bq", table = "p.d.t", minimum_backoff = "20s" }]
    cloud_storage_subscriptions = [{ name = "gcs", bucket = "b", minimum_backoff = "20s" }]
  }
  assert {
    condition     = google_pubsub_subscription.push_subscriptions["push"].retry_policy[0].minimum_backoff == "20s"
    error_message = "push"
  }
  assert {
    condition     = google_pubsub_subscription.pull_subscriptions["pull"].retry_policy[0].minimum_backoff == "20s"
    error_message = "pull"
  }
  assert {
    condition     = google_pubsub_subscription.bigquery_subscriptions["bq"].retry_policy[0].minimum_backoff == "20s"
    error_message = "bq"
  }
  assert {
    condition     = google_pubsub_subscription.cloud_storage_subscriptions["gcs"].retry_policy[0].minimum_backoff == "20s"
    error_message = "gcs"
  }
}
run "max_only_pull" {
  command = plan
  variables {
    pull_subscriptions = [{ name = "pull", maximum_backoff = "300s" }]
  }
  assert {
    condition     = google_pubsub_subscription.pull_subscriptions["pull"].retry_policy[0].maximum_backoff == "300s"
    error_message = "max"
  }
}
run "none" {
  command = plan
  variables {
    pull_subscriptions = [{ name = "pull" }]
  }
  assert {
    condition     = length(google_pubsub_subscription.pull_subscriptions["pull"].retry_policy) == 0
    error_message = "none"
  }
}
