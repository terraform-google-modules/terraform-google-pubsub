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

package cloudiot

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestCloudIot(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)

	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")

		op := gcloud.Runf(t, "iot registries describe cft-ci-iot-registry --region=%s --project=%s", "us-central1", projectId)
		assert.Equal(fmt.Sprintf("projects/%s/locations/%s/registries/cft-ci-iot-registry", projectId, "us-central1"), op.Get("name").String(), "has expected name")

		topicSuffixes := []string{"event-topic", "state-topic"}
		for _, suffix := range topicSuffixes {
			op = gcloud.Runf(t, "pubsub topics describe cft-ci-iot-registry-%s --project=%s", suffix, projectId)
			assert.Equal(fmt.Sprintf("projects/%s/topics/cft-ci-iot-registry-%s", projectId, suffix), op.Get("name").String(), "has expected name")

		}
		subSuffixes := []string{"event-pull", "state-push"}
		for _, suffix := range subSuffixes {
			op = gcloud.Runf(t, "pubsub subscriptions describe cft-ci-iot-registry-%s --project=%s", suffix, projectId)
			assert.Equal(fmt.Sprintf("projects/%s/subscriptions/cft-ci-iot-registry-%s", projectId, suffix), op.Get("name").String(), "has expected name")
		}
	})

	bpt.Test()
}
