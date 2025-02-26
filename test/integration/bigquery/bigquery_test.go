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

package bigquery

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestBigquery(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		op := gcloud.Runf(t, "pubsub topics describe cft-tf-pubsub-topic-bigquery --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic-bigquery", projectId), op.Get("name").String(), "has expected name")
		assert.Equal("bar_value", op.Get("labels.bar_label").String(), "has expected labels")
		assert.Equal("foo_value", op.Get("labels.foo_label").String(), "has expected labels")

		op = gcloud.Runf(t, "pubsub subscriptions describe example_subscription --project=%s", projectId)
		assert.Equal("", op.Get("RetryPolicy.minimumBackoff").String(), "has expected minimum_backoff")
		assert.Equal(fmt.Sprintf("projects/%s/subscriptions/example_subscription", projectId), op.Get("name").String(), "has expected name")
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic-bigquery", projectId), op.Get("topic").String(), "has expected topic")
		assert.Equal("10", op.Get("ackDeadlineSeconds").String(), "has expected ackDeadlineSeconds")
		assert.Equal(false, op.Get("enableExactlyOnceDelivery").Bool(), "has expected enable_exactly_once_delivery")
		assert.Equal(fmt.Sprintf("%s:example_dataset.example_table", projectId), op.Get("bigqueryConfig.table").String(), "has expected table")
		assert.Equal("604800s", op.Get("messageRetentionDuration").String(), "has expected message_retention_duration")
		assert.Equal("2678400s", op.Get("expirationPolicy.ttl").String(), "has expected expiration_policy")
		assert.Equal("", op.Get("filter").String(), "has expected filter")
		assert.Equal("", op.Get("deadLetterPolicy.deadLetterTopic").String(), "has expected dead_letter_topic")
		assert.Equal("", op.Get("deadLetterPolicy.maxDeliveryAttempts").String(), "has expected dead_letter_topic")
		assert.Equal("", op.Get("retryPolicy.maximumBackoff").String(), "has expected maximum_backoff")
		assert.Equal("", op.Get("retryPolicy.minimumBackoff").String(), "has expected minimum_backoff")
		assert.Equal(false, op.Get("bigqueryConfig.useTopicSchema").Bool(), "has expected use_topic_schema")
		assert.Equal(false, op.Get("bigqueryConfig.useTableSchema").Bool(), "has expected use_table_schema")
		assert.Equal(false, op.Get("bigqueryConfig.writeMetadata").Bool(), "has expected write_metadata")
		assert.Equal(false, op.Get("bigqueryConfig.dropUnknownFields").Bool(), "has expected drop_unknown_fields")
		assert.Equal(false, op.Get("bigqueryConfig.retainAckedMessages").Bool(), "has expected retain_acked")
	})

	bpt.Test()
}
