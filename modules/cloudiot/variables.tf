/**
 * Copyright 2019 Google LLC
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

variable "project_id" {
  type        = string
  description = "The project ID to manage the Cloud IoT resources"
}

variable "region" {
  type        = string
  description = "The region to host the registry"
}

variable "name" {
  type        = string
  description = "The Cloud IoT registry name"
}

variable "mqtt_enabled_state" {
  type        = string
  description = "The field allows MQTT_ENABLED or MQTT_DISABLED"
  default     = "MQTT_ENABLED"
}

variable "http_enabled_state" {
  type        = string
  description = "The field allows HTTP_ENABLED or HTTP_DISABLED"
  default     = "HTTP_DISABLED"
}

variable "public_key_certificates" {
  type        = list(object({ format = string, certificate = string }))
  description = "The list for public key certificates"
  default     = []
}

variable "event_notification_config" {
  type = object({
    topic              = string
    topic_labels       = map(string)
    push_subscriptions = list(map(string))
    pull_subscriptions = list(map(string))
    create_topic       = bool
  })
  description = "The event notification configuration for the Cloud IoT registry. This contains `topic`, `topic_labels`, `pull_subscriptions` and `push_subscriptions` and `create_topic`."
  default = {
    topic              = ""
    topic_labels       = {}
    push_subscriptions = []
    pull_subscriptions = []
    create_topic       = false
  }
}

variable "state_notification_config" {
  type = object({
    topic              = string
    topic_labels       = map(string)
    push_subscriptions = list(map(string))
    pull_subscriptions = list(map(string))
    create_topic       = bool
  })
  description = "The state notification configuration for the Cloud IoT registry. This contains `topic`, `topic_labels`, `pull_subscriptions` and `push_subscriptions` and `create_topic`."
  default = {
    topic              = ""
    topic_labels       = {}
    push_subscriptions = []
    pull_subscriptions = []
    create_topic       = false
  }
}
