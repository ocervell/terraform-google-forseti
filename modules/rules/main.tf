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

locals {
  default_rules_files = [
    "audit_logging_rules.yaml",
    "bigquery_rules.yaml",
    "blacklist_rules.yaml",
    "bucket_rules.yaml",
    "cloudsql_rules.yaml",
    "enabled_apis_rules.yaml",
    "external_project_access_rules.yaml",
    "firewall_rules.yaml",
    "forwarding_rules.yaml",
    "group_rules.yaml",
    "iam_rules.yaml",
    "iap_rules.yaml",
    "instance_network_interface_rules.yaml",
    "ke_rules.yaml",
    "ke_scanner_rules.yaml",
    "kms_rules.yaml",
    "lien_rules.yaml",
    "location_rules.yaml",
    "log_sink_rules.yaml",
    "resource_rules.yaml",
    "retention_rules.yaml",
    "service_account_key_rules.yaml",
  ]

  default_rules_path = "${path.module}/templates/rules/"
  rules_files        = ["${split(",", length(var.rules_files) != 0 ? join(",", var.rules_files) : join(",", local.default_rules_files))}"]
  rules_path         = "${var.rules_path != "" ? var.rules_path : local.default_rules_path}"
}

data "template_file" "main" {
  count    = "${length(local.rules_files)}"
  template = "${file("${local.rules_path}/${element(local.rules_files, count.index)}")}"

  vars {
    org_id = "${var.org_id}"
    domain = "${var.domain}"
  }
}

resource "google_storage_bucket_object" "main" {
  count   = "${length(local.rules_files)}"
  name    = "${element(local.rules_files, count.index)}"
  content = "${element(data.template_file.main.*.rendered, count.index)}"
  bucket  = "${var.bucket}"
}
