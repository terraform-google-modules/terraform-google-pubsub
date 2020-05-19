# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0](https://www.github.com/terraform-google-modules/terraform-google-pubsub/compare/v1.2.1...v1.3.0) (2020-05-19)


### Features

* Add custom KMS key support ([#25](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/25)) ([9516ff1](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/9516ff1cd7109adac92225caf819178e61281ff1))
* Add support for message_retention_duration ([#19](https://www.github.com/terraform-google-modules/terraform-google-pubsub/issues/19)) ([71a81ac](https://www.github.com/terraform-google-modules/terraform-google-pubsub/commit/71a81ac4607d89ef7bedf839810cce978fb50eb6))

## [Unreleased]

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
