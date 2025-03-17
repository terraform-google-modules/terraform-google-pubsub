// Copyright 2022 Google LLC
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

package push_subscription_separate_pub_sub

import (
	"fmt"
	"testing"
	"time"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestPushSubscriptionSeparatePubSub(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		op := gcloud.Runf(t, "pubsub topics describe cft-tf-pub-topic-cr-push --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pub-topic-cr-push", projectId), op.Get("name").String(), "has expected name")
		assert.Equal("bar_value", op.Get("labels.bar_label").String(), "has expected labels")
		assert.Equal("foo_value", op.Get("labels.foo_label").String(), "has expected labels")

		op = gcloud.Runf(t, "pubsub subscriptions describe cr-service --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/subscriptions/cr-service", projectId), op.Get("name").String(), "has expected name")
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pub-topic-cr-push", projectId), op.Get("topic").String(), "has expected topic")
		// Publish a test message
		message := "Hello Runner!"
		publishCmd := fmt.Sprintf("pubsub topics publish cft-tf-pub-topic-cr-push --message='%s' --project=%s", message, projectId)
		gcloud.Runf(t, publishCmd)

		// Wait for a short time to allow the message to be processed. Adjust if necessary.
		time.Sleep(30 * time.Second)

		// Check Cloud Run logs for the message
		logCmd := fmt.Sprintf("logging read \"resource.type=cloud_run_revision AND resource.labels.service_name=cr-service AND textPayload:\\\"%s\\\"\" --project=%s --limit=1", message, projectId)
		logOp := gcloud.Runf(t, logCmd)

		// Assert that the log entry is found
		assert.Contains(logOp.String(), message, "Cloud Run logs should contain the published message")
	})

	bpt.Test()
}
