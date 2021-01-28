# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
