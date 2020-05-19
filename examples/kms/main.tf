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
  version = "~> 2.13"
  region  = "us-central1"
}

data "google_project" "project" {
  project_id = var.project_id
}

locals {
  pubsub_svc_account_email = "service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

data "google_iam_role" "kms_encrypt_decrypt" {
  name = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

resource "google_kms_key_ring" "my_key_ring" {
  name     = "my-key-ring-crqif"
  location = "us-central1"
  project  = var.project_id
}

resource "google_kms_crypto_key" "my_crypto_key" {
  name     = "my-crypto-key-ra5jb"
  key_ring = google_kms_key_ring.my_key_ring.id
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = data.google_iam_role.kms_encrypt_decrypt.name
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
}

module "pubsub" {
  source             = "../../"
  project_id         = var.project_id
  topic              = var.topic_name
  topic_labels       = var.topic_labels
  topic_kms_key_name = google_kms_crypto_key.my_crypto_key.id

  pull_subscriptions = [
    {
      name                 = "pull"
      ack_deadline_seconds = 10
    },
  ]

  push_subscriptions = [
    {
      name                 = "push"
      push_endpoint        = "https://${var.project_id}.appspot.com/"
      x-goog-version       = "v1beta1"
      ack_deadline_seconds = 20
    },
  ]
}
