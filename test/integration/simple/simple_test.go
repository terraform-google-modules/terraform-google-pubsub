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

package simple

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSimple(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		op := gcloud.Runf(t, "pubsub topics describe cft-tf-pubsub-topic --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic", projectId), op.Get("name").String(), "has expected name")
		assert.Equal("bar_value", op.Get("labels.bar_label").String(), "has expected labels")
		assert.Equal("foo_value", op.Get("labels.foo_label").String(), "has expected labels")

		op = gcloud.Runf(t, "pubsub subscriptions describe pull --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/subscriptions/pull", projectId), op.Get("name").String(), "has expected name")
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic", projectId), op.Get("topic").String(), "has expected topic")
		assert.Equal("10", op.Get("ackDeadlineSeconds").String(), "has expected ackDeadlineSeconds")

		op = gcloud.Runf(t, "pubsub subscriptions describe push --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/subscriptions/push", projectId), op.Get("name").String(), "has expected name")
		assert.Equal(fmt.Sprintf("projects/%s/topics/cft-tf-pubsub-topic", projectId), op.Get("topic").String(), "has expected topic")
		assert.Equal("20", op.Get("ackDeadlineSeconds").String(), "has expected ackDeadlineSeconds")
		assert.Equal(fmt.Sprintf("https://%s.appspot.com/", projectId), op.Get("pushConfig.pushEndpoint").String(), "has expected pushEndpoint")

		op = gcloud.Runf(t, "pubsub schemas describe example --project=%s", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/schemas/example", projectId), op.Get("name").String(), "has expected name")

	})

	bpt.Test()
}
