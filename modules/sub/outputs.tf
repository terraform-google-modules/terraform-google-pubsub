/**
 * Copyright 2025 Google LLC
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

output "subscription_names" {
  value = concat(
    values({ for k, v in google_pubsub_subscription.push_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.pull_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.bigquery_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.cloud_storage_subscriptions : k => v.name }),
  )

  description = "The name list of Pub/Sub subscriptions"
}

output "subscription_paths" {
  value = concat(
    values({ for k, v in google_pubsub_subscription.push_subscriptions : k => v.id }),
    values({ for k, v in google_pubsub_subscription.pull_subscriptions : k => v.id }),
    values({ for k, v in google_pubsub_subscription.bigquery_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.cloud_storage_subscriptions : k => v.name }),
  )

  description = "The path list of Pub/Sub subscriptions"
}

