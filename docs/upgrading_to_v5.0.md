# Upgrading to v2.0

The v2.0 release of *terraform-google-pubsub* is a backwards incompatible release.

## Migration Instructions

### grant_token_creator deprecation

> When you have a push subscription with OIDC enabled, you need to have `roles/iam.serviceAccountTokenCreator` role added to Pub/Sub’s default SA. But if you would remove one subscription with all its resources it will delete a role as well, but some other subscriptions might still need to use it since there is just one default Pub/Sub service account per project.
>
> This role should be added on the project-factory-module level after you check that the Pub/Sub API is enabled.

- <https://github.com/terraform-google-modules/terraform-google-pubsub/pull/48#issue-762410597>

As per the above comment, we are deprecating the use of `grant_token_creator`, to ensure that the `google_project_iam_member.token_creator_binding` does not get
accidentally deleted, we are removing any default value for `grant_token_creator` and asking that users remove the resource from within this module's terraform state and set the variable to `false`. Failure to remove/move the state of the resource prior to setting the variable to `false` can result in push subscriptions with OIDC enabled failing.

The exact command to run will depend on wether you are removing, or moving the state, and the module name.

E.g. if the module is named  `pubsub` and you wanted the state removed:

```sh
terraform state rm 'module.pubsub.google_project_iam_member.token_creator_binding[0]'
```

E.g. if the module is named `pubsub` and you want to move the state to `google_project_iam_member.token_creator_binding` in a module called `some_other_module`:

```sh
terraform state mv 'module.pubsub.google_project_iam_member.token_creator_binding[0]' module.some_other_module.google_project_iam_member.token_creator_binding
```

- [terraform state mv command](https://developer.hashicorp.com/terraform/cli/commands/state/mv)
- [terraform state rm command](https://developer.hashicorp.com/terraform/cli/commands/state/rm)
