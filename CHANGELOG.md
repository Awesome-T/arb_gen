# Changelog

All notable changes to this project will be documented in this file.

## [0.0.3] - 2024-01-14

### Added

- Initial release
- Basic functionality for translation and localization using ARB files.
- Support for loading configuration from `arb.gen/config.json`.
- Parsing and translating ONLY data that shows in the UI to the user, metadata placeholders remain unchanged.
- Automatically check and add flutter_localizations, intl dependencies to pubspec.yaml
- Move generated files from .dart_tool directory to the folder specified in the settings.
- update Info.plist for iOS, macOs.
