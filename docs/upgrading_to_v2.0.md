# Upgrading to v2.0

The v2.0 release of *terraform-google-pubsub* is a backwards incompatible release.

## Migration Instructions



### Pubsub Subscription for_each
The `google_pubsub_subscription` resource has been updated to use `for_each` instead of `count`. This allows adding/removing subscriptions without causing a diff on unrelated subscriptions.

Updating to this new format requires a state migration.
All `google_pubsub_subscription.pull_subscriptions` and `google_pubsub_subscription.push_subscriptions` resources with numerical indexes in the state need to be moved to resources with named indexes, where each index is the name of the subscription.

For example:

```bash
terraform state mv 'google_pubsub_subscription.pull_subscriptions[0]' 'google_pubsub_subscription.pull_subscriptions["pull-subscription1-name"]'
terraform state mv 'google_pubsub_subscription.pull_subscriptions[1]' 'google_pubsub_subscription.pull_subscriptions["pull-subscription2-name"]'

terraform state mv 'google_pubsub_subscription.push_subscriptions[0]' 'google_pubsub_subscription.push_subscriptions["push-subscription1-name"]'
terraform state mv 'google_pubsub_subscription.push_subscriptions[1]' 'google_pubsub_subscription.push_subscriptions["push-subscription2-name"]'

```

### Topic and subscription IAM member

The `google_pubsub_topic_iam_member` and `google_pubsub_subscription_iam_member` resources also have been updated to use `for_each` instead of `count`.
But recreating these resources with `terraform apply` command instead of state migration is usually fine for most cases.
