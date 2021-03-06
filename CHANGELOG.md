# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed

- Fix `--version`.

## [1.2.0]
### Added

- Add `--ignore-nonexistent` argument to not emit diagnostic message when the
  passed filename does not exist.

## [1.1.0]
### Changed

- Use certificate issuer and subject rather than file line to identify a
  certificate in a certificate file.

## [1.0.1]
### Fixed

- Fix on Debian Stretch.

[Unreleased]: https://github.com/smortex/tls-checker/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/smortex/tls-checker/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/smortex/tls-checker/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/smortex/tls-checker/compare/v1.0.0...v1.0.1
