[![Pub package](https://img.shields.io/pub/v/arb_gen.svg)](https://pub.dev/packages/arb_gen)
[![Pub likes](https://badgen.net/pub/likes/arb_gen)](https://pub.dev/packages/arb_gen)
[![Dart Test](https://github.com/Awesome-T/arb_gen/actions/workflows/dart.yml/badge.svg)](https://github.com/Awesome-T/arb_gen/actions/workflows/dart.yml)
[![Buid status](https://github.com/Baseflow/flutter-geocoding/workflows/Geocoding/badge.svg)](https://github.com/Awesome-T/arb_gen/actions)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Awesome-T/arb_gen/blob/dev/LICENSE)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

# ARB Gen
<!-- ARB Gen is a Dart package designed to simplify the translation and localization process in Flutter projects using ARB (Application Resource Bundle) files. It automates the generation of translated ARB files, allowing you to focus on the translation itself. -->
ARB Gen is a powerful Dart package tailored for Flutter projects, streamlining the translation and localization processes through ARB (Application Resource Bundle) files. This package automates the generation of translated ARB files, providing a seamless experience for developers and allowing them to concentrate on the translation aspect. Key features include automatic translation from a base language to multiple target languages, effortless integration with Flutter projects, and a flexible configuration setup that accommodates customization through a configuration file or command line arguments. ARB Gen also supports dynamic updates, allowing Flutter apps to receive new translations without requiring manual intervention. Developers can easily install the package by adding a dependency to their pubspec.yaml file and running flutter pub get. With straightforward usage steps and clear integration instructions, ARB Gen enhances the localization workflow, making it efficient and developer-friendly.

## Features

- **Automatic Translation:** Translate your content from a base language to multiple target languages with ease.
- **Integration with Flutter:** Easily integrate the generated translations into your Flutter project.
- **Flexible Configuration:** Customize the translation process with a configuration file or command line arguments.
- **Dynamic Updates:** Dynamically update your Flutter app with new translations without manual intervention.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dev_dependencies:
  arb_gen: ^1.0.0
```

Then, run:

```bash
flutter pub get
```

## Usage

#### 1. Configuration

Create a configuration file arb.gen/config.json or use command line arguments to specify translation settings. Here's an example configuration file:

```json
{
  "translateTo": ["fr", "es"],
  "ignored": ["keyToIgnore"],
  "pathToFile": "arb.gen/content.json",
  "outputFolder": "lib/l10n/",
  "arbName": "localization",
  "baseLanguage": "en",
  "translater": "google",
  "apiKey": "YOUR_TRANSLATION_API_KEY",
  "allAtOnce": true
}
```

### 2. Run ARB Gen

Run the following command to execute the translation process:

```bash
dart run arb.gen.dart
```

### 3. Integration with Flutter

If allAtOnce is set to false in your configuration, follow these steps to integrate the generated translations into your Flutter project:

#### 3.1 Update pubspec.yaml

```yaml
flutter:
  generate: true

dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.17.0
```

#### 3.2 Create l10n.yaml

```yaml
arb-dir: lib/l10n
template-arb-file: localization_en.arb
output-localization-file: app_localizations.dart
```

#### 3.3 Run Flutter Pub Get

Run the following command to fetch the dependencies and generate the localized files:

```bash
flutter pub get
```

#### 3.4 Move Generated Files Manually

Manually move the generated ARB files from the specified output folder (lib/l10n/ by default) to your project's localization folder.

```bash
mv generated_arb_files/* lib/l10n/
```

#### 3.5 Updating the iOS app bundle

[See the documentation on the website.](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#localizing-for-ios-updating-the-ios-app-bundle)
