[![Pub package](https://img.shields.io/pub/v/arb_gen.svg)](https://pub.dev/packages/arb_gen)
[![GH: WiKi](https://img.shields.io/badge/FAQ-90e22b)](https://github.com/Awesome-T/arb_gen/wiki/FAQ)
[![CI](https://github.com/Awesome-T/arb_gen/actions/workflows/ci.yaml/badge.svg)](https://github.com/Awesome-T/arb_gen/actions)
[![Pub likes](https://badgen.net/pub/likes/arb_gen)](https://pub.dev/packages/arb_gen)
![GH: issues](https://img.shields.io/github/issues/Awesome-T/arb_gen)
![GH: PRs](https://img.shields.io/github/issues-pr/Awesome-T/arb_gen)
![GH: last commit](https://img.shields.io/github/last-commit/Awesome-T/arb_gen?color=blue&logo=GitHub&style=flat)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](ttps://github.com/Naereen/StrapDown.js/graphs/commit-activity)
![GitHub Discussions](https://img.shields.io/github/discussions/Awesome-T/arb_gen)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Awesome-T/arb_gen/blob/dev/LICENSE)

# ARB Gen

ARB Gen is a powerful Dart package tailored for Flutter projects, streamlining the translation and localization processes through ARB (Application Resource Bundle) files. This package automates the generation of translated ARB files, providing a seamless experience for developers and allowing them to concentrate on the translation aspect. Key features include automatic translation from a base language to multiple target languages, effortless integration with Flutter projects, and a flexible configuration setup that accommodates customization through a configuration file or command line arguments. ARB Gen also supports dynamic updates, allowing Flutter apps to receive new translations without requiring manual intervention. Developers can easily install the package by adding a dependency to their pubspec.yaml file and running flutter pub get. With straightforward usage steps and clear integration instructions, ARB Gen enhances the localization workflow, making it efficient and developer-friendly.

![!\[Alt text\](assets/arb_gen-1706034100144.gif)](assets/example.gif)

## Features

- **Automatic Translation:** Translate your content from a base language to multiple target languages with ease.
- **Integration with Flutter:** Easily integrate the generated translations into your Flutter project.
- **Flexible Configuration:** Customize the translation process with a configuration file or command line arguments.
- **Dynamic Updates:** Dynamically update your Flutter app with new translations without manual intervention.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dev_dependencies:
  arb_gen:
```

Then, run:

```bash
flutter pub get
```

## Usage

### 1. Configuration

Create a configuration file arb.gen/config.json. Here's an example configuration file:

```json
{
  "translateTo": ["fr", "es"],
  "ignored": ["appName"],
  "pathToFile": "arb.gen/content.json",
  "outputFolder": "lib/l10n/",
  "arbName": "localization",
  "baseLanguage": "en",
  "translater": null,
  "apiKey":null,
  "allAtOnce": true
}
```

Note: by default we prefer google translator, this aproach dont need any API-key,
if field `translater` it'lll the same as 'google' .

 Output directory for all generated .arb files. Defaults to 'lib/l10n'.

#### s

| Property          | Type           | Description                                                      |
| ----------------- | -------------- | ---------------------------------------------------------------- |
| translateTo       | List<String>   | Codes of languages for which localization is required.           |
| preferredLanguage | String?        | Preferred language code; if `null`, it defaults to the first language in `translateTo`. |
| baseLanguage      | String?        | Code of the original language used in the base file.               |
| ignored           | List<String>   | Keys from the card that don't need to be transferred. Usually, these are custom keys (e.g., the application name). |
| outputClass       | String?        | Name of the output class for localization. Defaults to `class $L{}`. |
| lDirName          | String         | Path to the local service folder. Defaults to `/lib/$outPutFolder`. |
| arbName           | String         | Name for .arb files; follows the pattern `arbName_languageCode.arb`. |
| translater        | ['deepl', 'yandex', 'google', 'azure', 'microsoft', 'openAI']     | The name of the service to be translated. Defaults to Google Translator |
| apiKey            | String?        | API key for the translation service. Not required for Google Translator. |
| allAtOnce         | bool?          | Flag to generate all translations at once. Defaults to `true`.     |
| pathToFile        | String         | Path to the original .arb/.json file. Defaults to 'arb.gen/content.json'. |

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
  intl:
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

#### Translated example

<table>
    <tbody>
        <tr>
            <td align="center">
                <b> DE </>
            </td>
            <td align="center">
                <b> FR </>
            </td>
            <td align="center">
                <b> EN </>
            </td>
            <td align="center">
                <b> ES </>
            </td>
        </tr>
        <tr>
            <td align="center">
                <a href="https://github.com/Awesome-T/arb_gen/blob/main/assets/de.png">
                    <img src="assets\de.png" width="225" height=255 />
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/Awesome-T/arb_gen/blob/main/assets/fr.png">
                    <img src="assets\fr.png" width="225" height=255 />
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/Awesome-T/arb_gen/blob/main/assets/en.png">
                    <img src="assets\en.png" width="225" height=255 />
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/Awesome-T/arb_gen/blob/main/assets/es.png">
                    <img src="assets\es.png" width="200" height=255 />
                </a>
            </td>
        </tr>
    </tbody>
</table>

## Maintainers

- [@Awesome-T](https://github.com/Awesome-T)
