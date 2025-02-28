// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cloud_storage

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestCloudStorage(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		op := gcloud.Runf(t, "pubsub topics describe cft-tf-pubsub-topic-cloud-storage --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic-cloud-storage", projectId), op.Get("name").String(), "has expected name")
		assert.Equal("foo_value", op.Get("labels.foo_label").String(), "has expected labels")

		op = gcloud.Runf(t, "pubsub subscriptions describe example_bucket_subscription --project=%s", projectId)
		assert.Equal("", op.Get("RetryPolicy.minimumBackoff").String(), "has expected minimum_backoff")
		assert.Equal(fmt.Sprintf("projects/%s/subscriptions/example_bucket_subscription", projectId), op.Get("name").String(), "has expected name")
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic-cloud-storage", projectId), op.Get("topic").String(), "has expected topic")
		assert.Equal("300", op.Get("ackDeadlineSeconds").String(), "has expected ackDeadlineSeconds")
		assert.Equal(false, op.Get("enableExactlyOnceDelivery").Bool(), "has expected enable_exactly_once_delivery")
		assert.Equal("604800s", op.Get("messageRetentionDuration").String(), "has expected message_retention_duration")
		assert.Equal("2678400s", op.Get("expirationPolicy.ttl").String(), "has expected expiration_policy")
		assert.Equal("", op.Get("filter").String(), "has expected filter")
		assert.Equal("", op.Get("deadLetterPolicy.deadLetterTopic").String(), "has expected dead_letter_topic")
		assert.Equal("", op.Get("deadLetterPolicy.maxDeliveryAttempts").String(), "has expected dead_letter_topic")
		assert.Equal("", op.Get("retryPolicy.maximumBackoff").String(), "has expected maximum_backoff")
		assert.Equal("", op.Get("retryPolicy.minimumBackoff").String(), "has expected minimum_backoff")
		assert.Equal("example_prefix_", op.Get("cloudStorageConfig.filenamePrefix").String(), "has expected filename_prefix")
		assert.Equal("_example_suffix", op.Get("cloudStorageConfig.filenameSuffix").String(), "has expected filename_suffix")
		assert.Equal("300s", op.Get("cloudStorageConfig.maxDuration").String(), "has expected filename_prefix")
		assert.Equal("YYYY-MM-DD/hh_mm_ssZ", op.Get("cloudStorageConfig.filenameDatetimeFormat").String(), "has expected filename_datetime_format")
		assert.Equal(false, op.Get("cloudStorageConfig.avroConfig").Bool(), "has expected avro_config")
	})

	bpt.Test()
}
