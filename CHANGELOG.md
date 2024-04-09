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


## [0.0.4] - 2024-01-24

### Edited
 Supported languages, and added an example.
- the list of languages for localization corresponds to kMaterialSupportedLanguages.
- an example for a Mac has been falsely added; the file with the localization field is automatically updated.
- the readme file has been updated.

## [0.0.5] - 2024-04-09
Fixed an bug in determining the source file path specified in the preferences.
