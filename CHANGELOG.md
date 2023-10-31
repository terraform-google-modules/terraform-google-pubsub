# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
