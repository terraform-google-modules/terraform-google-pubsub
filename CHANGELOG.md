# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [8.3.2](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.3.1...v8.3.2) (2025-09-30)


### Bug Fixes

* added missing validations ([#273](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/273)) ([736fcb3](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/736fcb3b0a93051673e42f44ced2ed43ea562953))

## [8.3.1](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.3.0...v8.3.1) (2025-09-22)


### Bug Fixes

* Add validation in UI for pubsub ([#266](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/266)) ([b65840a](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/b65840ab81e2aa7d488f3e1cf7b515469259c5ca))

## [8.3.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.2.0...v8.3.0) (2025-09-12)


### Features

* **deps:** Update Terraform google to v7 ([#269](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/269)) ([ebacb35](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/ebacb35d6b3d32cc2383d3f60293c1cfe8553298))
* per module requirements configs for pubsub ([#264](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/264)) ([cce55dd](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/cce55dda7a2898a1305623a5de615b56a78d1723))

## [8.2.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.1.2...v8.2.0) (2025-04-22)


### Features

* Add conditional storage iam binding ([#255](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/255)) ([4fca125](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/4fca125ba08508fa796ed7b64563c9534643c60b))
* Adding bigquery connection ([#258](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/258)) ([a521f4e](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/a521f4e678dfc828fadb54a60661146da9a4ade1))


### Bug Fixes

* fixed topic regex to make it compatible with golang re2 ([#254](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/254)) ([4e92a87](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/4e92a870373df7323a1c7ab1ddad48b030e8b3f7))

## [8.1.2](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.1.1...v8.1.2) (2025-04-01)


### Features

* Add missing attribute no_wrapper option to push subscription ([#249](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/249)) ([295df92](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/295df925d7d5b80c47c483836189563a9d4baee5))

## [8.1.1](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.1.0...v8.1.1) (2025-03-20)


### Bug Fixes

* Update metadata to remove connection with bigquery ([#248](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/248)) ([c29d2d5](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/c29d2d538d562ba1acf6ac06898781f08904d0ff))

## [8.1.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.0.1...v8.1.0) (2025-03-18)


### Features

* Add missing attribute to bigquery subscription and cloud storage subscription variables ([#238](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/238)) ([ce061a0](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/ce061a0b0651e1d85d09c13d4471cb94e29c2a17))
* add new output variable env_vars ([#241](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/241)) ([9afa4af](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/9afa4af690e59f877b2dd48fb07203b95c416f89))
* Add submodules for pub and sub ([#234](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/234)) ([0e44fc6](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/0e44fc67a302abb3b266e136e7f0f1c44b4987cd))


### Bug Fixes

* re-enable expiration_policy for pull subscription, fix push subscription generation with empty expiration_policy ([#232](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/232)) ([5f793ad](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/5f793added4f1cbf1d9184f6a3273b581f281a91))

## [8.0.1](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v8.0.0...v8.0.1) (2025-03-10)


### Bug Fixes

* use string for maximum_backoff and minimum_backoff for pull subscriptions ([#229](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/229)) ([e4eea2a](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/e4eea2a57917ce652a52de8fb831a138f99d016d))

## [8.0.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v7.0.0...v8.0.0) (2025-03-05)


### ⚠ BREAKING CHANGES

* **TPG>=6.2:** add cloud storage max_messages and use_topic_schema support ([#204](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/204))

### Features

* **TPG>=6.2:** add cloud storage max_messages and use_topic_schema support ([#204](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/204)) ([bc66597](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/bc66597a04fcdd819b9b42bb2ec5cbec3d151524))


### Bug Fixes

* **deps:** bump TF v1.3+ ([#212](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/212)) ([70bf8b1](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/70bf8b1bfc4bc7abde78cf13f5a0ced0b51e0cfa))
* migrate bigquery_subscription and cloud_storage_subscription variables to objects ([#222](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/222)) ([8b06b62](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/8b06b62d0c656160f620ffbff124ff62d228a85b))
* migrate pull_subscriptions and push_subscriptions to object lists ([#224](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/224)) ([f239247](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/f23924757405313c452a9bd94f888a09b1093636))
* return bigquery subscription use_topic_schema variable default value back to false ([#225](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/225)) ([10b8b6b](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/10b8b6bb723296b610bd6113d9c6f622bd6f64ed))

## [7.0.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v6.0.0...v7.0.0) (2024-09-13)


### ⚠ BREAKING CHANGES

* **TPG>=5.31:** add cloud storage filename datetime format support ([#192](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/192))
* resolve Unforeseen Behavior when changing filter - missing bindings on first apply run #173 ([#174](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/174))

### Features

* add enable_message_ordering attribute for push subscription ([#195](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/195)) ([c310330](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/c3103305a150c55a720b8d94e2ab6fc493efe9b3))
* add pubsub iam member for bigquery subscription dead letter topics ([#146](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/146)) ([a413f03](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/a413f03e533fc88c1a618b475f5196d421e1f9f1))
* **deps:** Update Terraform google to v6 ([#203](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/203)) ([b02fd35](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/b02fd351456a074a5d88c229147e8d1f8e18fe1b))
* limit replace_triggered_by to changed subscription ([#191](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/191)) ([deb704e](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/deb704e0d0642435cc745edc3df1100abe0da527))
* make granting service agent bigquery roles optional ([#183](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/183)) ([9508971](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/950897124678a26102c06aa92a3cb080a43df272))
* Support use_table_schema bigquery option ([#180](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/180)) ([834f204](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/834f20481a6a634af91aed713e58b02ee6490dd9))
* **TPG>=5.31:** add cloud storage filename datetime format support ([#192](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/192)) ([46a264b](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/46a264bd2c23c61e9138c467a191b745424b18dc))


### Bug Fixes

* resolve Unforeseen Behavior when changing filter - missing bindings on first apply run [#173](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/173) ([#174](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/174)) ([c496f56](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/c496f56a31f76e23f8414a03e02ad09aa2188f14))

## [6.0.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v5.0.0...v6.0.0) (2023-10-31)


### ⚠ BREAKING CHANGES

* **TPG>=4.78:** add cloud storage subscription support ([#145](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/145))
* remove iot ([#143](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/143))

### Features

* **TPG>=4.78:** add cloud storage subscription support ([#145](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/145)) ([95863ab](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/95863ab6e5d09919adc8cbbb97f12e6e064ad892))


### Bug Fixes

* remove iot ([#143](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/143)) ([dca11ae](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/dca11aed04d76c44be9e7d58e5d4f6f9cee06b8f))
* upgraded versions.tf to include minor bumps from tpg v5 ([#153](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/153)) ([2bdbea6](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/2bdbea6aeff1315a1aa8a6b52e7f7a8e82a54ec8))

## [5.0.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v4.0.1...v5.0.0) (2022-12-30)


### ⚠ BREAKING CHANGES

* ✨ added bigquery subscription capability, require TPG >= 4.32 #101

### Features

* ✨ added bigquery subscription capability, require TPG &gt;= 4.32 [#101](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/101) ([466a9ec](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/466a9ec1cb36e69d975072f22dd12e05a45fa233))


### Bug Fixes

* don't grant fwding permissions if no DLT present ([#108](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/108)) ([52c3b13](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/52c3b136a943dea13c57614f95d658581a884fbd))
* fixes lint issues and generates metadata ([#117](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/117)) ([5b08d0b](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/5b08d0b14965c07a61011d28431dbb3cf258f1d5))

## [4.0.1](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v4.0.0...v4.0.1) (2022-08-06)


### Bug Fixes

* Add_enable_exactly_once_delivery_on_a_PubSub_subscription ([#98](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/98)) ([0ad3dd6](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/0ad3dd6816e8b7bd30969bdcb08d12007b600105))
* remove unused variable and use null as default ([#100](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/100)) ([57e8ea1](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/57e8ea1ba820864d23c05f62cc714994f76e7553))

## [4.0.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v3.2.0...v4.0.0) (2022-07-26)


### ⚠ BREAKING CHANGES

* Increased minimum Google Provider version to 4.17 (#94)

### Features

* Add the ability to set the message_retention_duration on a PubSub topic ([#93](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/93)) ([56ce3fc](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/56ce3fc0354c8194fb699c52a01abaa2784da202))
* Add_enable_exactly_once_delivery_on_a_PubSub_subscription ([#94](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/94)) ([9b6b913](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/9b6b91383097df226951c48c0e0b3df86795a842))

## [3.2.0](https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v3.1.0...v3.2.0) (2022-02-09)


### Features

* add schema support ([#83](https://github.com/terraform-google-modules/terraform-google-pubsub/issues/83)) ([4c9e224](https://github.com/terraform-google-modules/terraform-google-pubsub/commit/4c9e224d4922abc77e01f95f7e9332503984a212))

## [3.1.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v3.0.0...v3.1.0) (2021-11-22)


### Features

* update TPG version constraints to allow 4.0 ([#77](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/77)) ([4e408a5](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/4e408a597b9333b61e5d70005c2eb63bbdabfd3f))


### Bug Fixes

* update subscription_paths op to id which has an identical value ([#78](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/78)) ([01413fb](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/01413fb8e13a5503e8b73dab7c28bbb2ad850af9))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v2.0.0...v3.0.0) (2021-09-02)


### ⚠ BREAKING CHANGES

* The `create_subscriptions` variable is now used to control whether subscriptions should be created. Set `create_subscriptions = false` *and* `create_topic = false` if you don't want the module to do anything.

### Features

* Allow creating subscriptions without creating topic ([#72](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/72)) ([0c25bf2](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/0c25bf2f4f736a5008d680a04cc43409993e858b))

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.9.0...v2.0.0) (2021-04-07)


### ⚠ BREAKING CHANGES

* The state location for subscriptions has moved, see the [upgrade guide](https://github.com/terraform-google-modules/terraform-google-pubsub/blob/master/docs/upgrading_to_v2.0.md) for details.
* Add Terraform 0.13 constraint and module attribution (#64)

### Features

* Add Terraform 0.13 constraint and module attribution ([#64](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/64)) ([bf6a051](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/bf6a051fdc6346ca6966467e56643a3a7a358eb7))
* Grant pull subscription permissions for external service account ([#68](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/68)) ([6cd0fc4](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/6cd0fc480ca0db204c741d167a61ea2fa671d753))


### Bug Fixes

* Use subscription names as the keys instead of numeric indexes ([#67](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/67)) ([b07ab12](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/b07ab1225383148e3f7fa8517ffcf87d17e2d405))

## [1.9.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.8.0...v1.9.0) (2021-02-02)


### Features

* allow the module to control retain_acked_messages ([#36](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/36)) ([8d44bfd](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/8d44bfddfa5070c50c68c033f173245ab55feed4))

## [1.8.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.7.0...v1.8.0) (2021-01-20)


### Features

* Add labels to every subscription ([#55](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/55)) ([ca431e4](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/ca431e46356019fce8e9fee0d0356ff85948ab86))

## [1.7.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.6.0...v1.7.0) (2020-12-23)


### Features

* Add support to filter and enable_message_ordering ([#52](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/52)) ([cb9700b](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/cb9700bc1d1addda284423add2ada00046ffa4f3))


### Bug Fixes

* Add flag to control token creator role binding ([#48](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/48)) ([6a89f24](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/6a89f24f5591b9f6a0499919a594e64fbf732726))
* Fix oidc_service_account_email on readme ([#54](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/54)) ([17dcf2a](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/17dcf2ada8587941be4fe78891e9b191d2c66528))

## [1.6.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.5.0...v1.6.0) (2020-11-13)


### Features

* Add token creator binding for service account ([#37](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/37)) ([112607c](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/112607cc503d9d884fe66c85d9fc6143ed84ceb5))
* Adding support for retry_policy.maximum_backoff and retry_policy.minimum_backoff ([#40](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/40)) ([4972a25](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/4972a25046ba554e622ca27bb735572d31397814))
* Use non-authoritative iam binding for subscription ([#46](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/46)) ([b8390bd](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/b8390bda9b445cc44c30482b2c52cc2e533d53d9)), closes [#44](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/44)

## [1.5.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.4.0...v1.5.0) (2020-09-21)


### Features

* Add iam bindings to the default pub/sub service account ([#34](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/34)) ([c3b08e4](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/c3b08e47a72b8d238d8ba2b16a31e6ad5f760aed))
* Add support for dead_letter_policy to subscription resources ([#32](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/32)) ([5005366](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/500536636fee1b4a8cfe909b42276a341b8533b3))

## [1.4.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.3.0...v1.4.0) (2020-07-20)


### Features

* Add OIDC token support ([#28](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/28)) ([f64f8d1](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/f64f8d1bb5ee7e6056acecf92922c2579d60a569))
* Add support for expiration_policy ([#23](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/23)) ([feca6f5](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/feca6f52d87721b22d4d97e83eb97c0270228159))

## [1.3.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.2.1...v1.3.0) (2020-05-19)


### Features

* Add custom KMS key support ([#25](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/25)) ([9516ff1](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/9516ff1cd7109adac92225caf819178e61281ff1))
* Add support for message_retention_duration ([#19](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/19)) ([71a81ac](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/71a81ac4607d89ef7bedf839810cce978fb50eb6))

## [1.2.1] - 2019-12-18

### Fixed

- Output values from destroyed resources no longer cause errors. [#16]

## [1.2.0] - 2019-12-09

### Added

- Add support for message_storage_policy to customize locations [#15]
- Add support for configuring Cloud IoT through [new submodule](./modules/cloudiot) [#4](https://github.com/terraform-google-modules/terraform-google-pubsub/pull/4)

## [1.1.0] - 2019-09-11

- Added topic_labels variable to define map of key/value label pairs to assign to Pub/Sub topic. [#11]

## [1.0.0] - 2019-07-26

### Changed

- Supported version of Terraform is 0.12. [#7]

## [0.2.0] - 2019-03-08

### Added

- `id` and `uri` outputs. [#2]

## [0.1.0] - 2018-10-25

### Added

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.2.1...HEAD
[1.2.1]: https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v0.2.0...v1.0.0
[0.2.0]: https://github.com/terraform-google-modules/terraform-google-pubsub/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-pubsub/releases/tag/v0.1.0

[#16]: https://github.com/terraform-google-modules/terraform-google-pubsub/issues/16
[#15]: https://github.com/terraform-google-modules/terraform-google-pubsub/pull/15
[#7]: https://github.com/terraform-google-modules/terraform-google-pubsub/pull/7
[#2]: https://github.com/terraform-google-modules/terraform-google-pubsub/pull/2
[#11]: https://github.com/terraform-google-modules/terraform-google-pubsub/pull/11
