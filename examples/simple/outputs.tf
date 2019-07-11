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

output "topic" {
  value       = "${module.pubsub.topic}"
  description = "The name of the Pub/Sub topic"
}

output "id" {
  value       = "${module.pubsub.id}"
  description = "The ID of the Pub/Sub topic"
}

output "uri" {
  value       = "${module.pubsub.uri}"
  description = "The URI of the Pub/Sub topic"
}

output "subscription_names" {
  value       = "${module.pubsub.subscription_names}"
  description = "The name list of Pub/Sub subscriptions"
}

output "subscription_paths" {
  value       = "${module.pubsub.subscription_paths}"
  description = "The path list of Pub/Sub subscriptions"
}

output "subscriptions" {
  value = "${module.pubsub.subscriptions}"

  description = "The name list of Pub/Sub subscriptions"
}
