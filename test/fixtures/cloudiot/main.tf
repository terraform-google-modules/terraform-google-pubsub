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

resource "tls_private_key" "private_keys" {
  count     = 2
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "certs" {
  count           = 2
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.private_keys[count.index].private_key_pem
  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }
  validity_period_hours = 12
  allowed_uses          = []
}

module "iot" {
  source        = "../../../examples/cloudiot"
  project_id    = var.project_id
  name          = "cft-ci-iot-registry"
  region        = "us-central1"
  rsa_cert1_pem = tls_self_signed_cert.certs[0].cert_pem
  rsa_cert2_pem = tls_self_signed_cert.certs[1].cert_pem
}
