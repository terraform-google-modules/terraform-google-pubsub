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
