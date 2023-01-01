# Upgrading to v6.0

The v6.0 release of *terraform-google-pubsub* is a backwards incompatible release.

## Migration Instructions

### grant_token_creator removal

If you've already set `grant_token_creator` to false, congrats, you can skip this entire section. :)

If not...

> When you have a push subscription with OIDC enabled, you need to have `roles/iam.serviceAccountTokenCreator` role added to Pub/Sub’s default SA. But if you would remove one subscription with all its resources it will delete a role as well, but some other subscriptions might still need to use it since there is just one default Pub/Sub service account per project.
>
> This role should be added on the project-factory-module level after you check that the Pub/Sub API is enabled.

- <https://github.com/terraform-google-modules/terraform-google-pubsub/pull/48#issue-762410597>

As per the above comment, the `grant_token_creator` option has been removed. To ensure that the `google_project_iam_member.token_creator_binding` does not get
accidentally deleted, module users must remove the resource from within this module's terraform state or move it to another module/resource. Failure to remove/move the state of the resource prior to upgrading can result in push subscriptions with OIDC enabled failing.

The exact command to run will depend on wether you are removing, or moving the state, and the module name.

E.g. if the module is named  `pubsub` and you wanted the state removed:

```sh
terraform state rm 'module.pubsub.google_project_iam_member.token_creator_binding[0]'
```

E.g. if the module is named `pubsub` and you want to move the state to `google_project_iam_member.token_creator_binding` in a module called `some_other_module`:

```sh
terraform state mv 'module.pubsub.google_project_iam_member.token_creator_binding[0]' module.some_other_module.google_project_iam_member.token_creator_binding
```

Another option could be to move the state to an instantiation of the [`terraform-google-project-factory`](https://github.com/terraform-google-modules/terraform-google-project-factory) module.

First, declare the role association, something like:

```hcl
module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "14.1.0"
  ...
  ...
  activate_api_identities = [{
    api = "pubsub.googleapis.com"
    roles = [ "roles/iam.serviceAccountTokenCreator"]
  }]
}
```

And then before applying:

```sh
terraform state mv 'module.pubsub.google_project_iam_member.token_creator_binding[0]' 'module.project_services.google_project_iam_member["pubsub.googleapis.com roles/iam.serviceAccountTokenCreator"].project_service_identity_roles'
```

et voilà!

- [terraform state mv command](https://developer.hashicorp.com/terraform/cli/commands/state/mv)
- [terraform state rm command](https://developer.hashicorp.com/terraform/cli/commands/state/rm)
