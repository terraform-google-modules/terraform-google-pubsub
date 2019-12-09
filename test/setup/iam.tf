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

locals {
  int_required_roles = [
    "roles/cloudiot.admin",
    "roles/pubsub.editor"
  ]
}

resource "random_id" "random_suffix" {
  byte_length = 2
}

resource "google_service_account" "int_test" {
  project      = module.project-ci-int-pubsub.project_id
  account_id   = "ci-int-test-${random_id.random_suffix.hex}"
  display_name = "ci-account"
}

resource "google_project_iam_member" "int_test" {
  count = length(local.int_required_roles)

  project = module.project-ci-int-pubsub.project_id
  role    = local.int_required_roles[count.index]
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}

// Even if granting roles/cloudiot.admin to the service account in advance,
// the roles cannot be applied immediately. As a result, our test will fail.
// To avoid that, we use null_resource for `sleep`ing 60 seconds.
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  depends_on = [google_project_iam_member.int_test]
}
