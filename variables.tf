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

variable "project_id" {
  type        = string
  description = "The project ID to manage the Pub/Sub resources."
}

variable "topic" {
  type        = string
  description = "The Pub/Sub topic name."
}

variable "create_topic" {
  type        = bool
  description = "Specify true if you want to create a topic."
  default     = true
}

variable "create_subscriptions" {
  type        = bool
  description = "Specify true if you want to create subscriptions."
  default     = true
}
variable "topic_labels" {
  type        = map(string)
  description = "A map of labels to assign to the Pub/Sub topic."
  default     = {}
}

variable "push_subscriptions" {
  type = list(object({
    name                       = string,
    ack_deadline_seconds       = optional(number),
    push_endpoint              = optional(string),
    x-goog-version             = optional(string),
    oidc_service_account_email = optional(string),
    audience                   = optional(string),
    expiration_policy          = optional(string),
    dead_letter_topic          = optional(string),
    retain_acked_messages      = optional(bool),
    message_retention_duration = optional(string),
    max_delivery_attempts      = optional(number),
    maximum_backoff            = optional(string),
    minimum_backoff            = optional(string),
    filter                     = optional(string),
    enable_message_ordering    = optional(bool),
    no_wrapper                 = optional(bool),
    write_metadata             = optional(bool),
  }))
  description = "The list of the push subscriptions."
  default     = []
}

variable "pull_subscriptions" {
  type = list(object({
    name                         = string,
    ack_deadline_seconds         = optional(number),
    expiration_policy            = optional(string),
    dead_letter_topic            = optional(string),
    max_delivery_attempts        = optional(number),
    retain_acked_messages        = optional(bool),
    message_retention_duration   = optional(string),
    maximum_backoff              = optional(string),
    minimum_backoff              = optional(string),
    filter                       = optional(string),
    enable_message_ordering      = optional(bool),
    service_account              = optional(string),
    enable_exactly_once_delivery = optional(bool),
  }))
  description = "The list of the pull subscriptions."
  default     = []
}

variable "bigquery_subscriptions" {
  type = list(object({
    name                       = string,
    table                      = string,
    use_topic_schema           = optional(bool),
    use_table_schema           = optional(bool),
    write_metadata             = optional(bool),
    drop_unknown_fields        = optional(bool),
    ack_deadline_seconds       = optional(number),
    retain_acked_messages      = optional(bool),
    message_retention_duration = optional(string),
    enable_message_ordering    = optional(bool),
    expiration_policy          = optional(string),
    filter                     = optional(string),
    dead_letter_topic          = optional(string),
    max_delivery_attempts      = optional(number),
    maximum_backoff            = optional(string),
    minimum_backoff            = optional(string)
  }))
  description = "The list of the Bigquery push subscriptions."
  default     = []
}

variable "cloud_storage_subscriptions" {
  type = list(object({
    name                       = string,
    bucket                     = string,
    filename_prefix            = optional(string),
    filename_suffix            = optional(string),
    filename_datetime_format   = optional(string),
    max_duration               = optional(string),
    max_bytes                  = optional(string),
    max_messages               = optional(string),
    output_format              = optional(string),
    write_metadata             = optional(bool),
    use_topic_schema           = optional(bool),
    ack_deadline_seconds       = optional(number),
    retain_acked_messages      = optional(bool),
    message_retention_duration = optional(string),
    enable_message_ordering    = optional(bool),
    expiration_policy          = optional(string),
    filter                     = optional(string),
    dead_letter_topic          = optional(string),
    max_delivery_attempts      = optional(number),
    maximum_backoff            = optional(string),
    minimum_backoff            = optional(string)
  }))
  description = "The list of the Cloud Storage push subscriptions."
  default     = []
}

variable "subscription_labels" {
  type        = map(string)
  description = "A map of labels to assign to every Pub/Sub subscription."
  default     = {}
}

variable "topic_message_retention_duration" {
  type        = string
  description = "The minimum duration in seconds to retain a message after it is published to the topic."
  default     = null
}

variable "message_storage_policy" {
  type        = map(any)
  description = "A map of storage policies. Default - inherit from organization's Resource Location Restriction policy."
  default     = {}
}

variable "topic_kms_key_name" {
  type        = string
  description = "The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic."
  default     = null
}

variable "grant_bigquery_project_roles" {
  type        = bool
  description = "Specify true if you want to add bigquery.metadataViewer and bigquery.dataEditor roles to the default Pub/Sub SA."
  default     = true
}

variable "grant_cloud_storage_project_roles" {
  type        = bool
  description = "Specify true if you want to add storage.admin role to the default Pub/Sub SA."
  default     = true
}

variable "grant_token_creator" {
  type        = bool
  description = "Specify true if you want to add token creator role to the default Pub/Sub SA."
  default     = true
}

variable "schema" {
  type = object({
    name       = string
    type       = string
    definition = string
    encoding   = string
  })
  description = "Schema for the topic."
  default     = null
}
