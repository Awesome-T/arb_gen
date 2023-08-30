<!-- [GitHub](https://github.com/Awesome-T/arb_gen) | [Pub](https://pub.dev/packages//arb_gen) -->
[![Pub package](https://img.shields.io/pub/v/arb_gen.svg)](https://pub.dev/packages/arb_gen)

[![Pub likes](https://badgen.net/pub/likes/arb_gen)](https://pub.dev/packages/arb_gen)
<!-- [![Pub likes](https://img.shields.io/pub/likes/lint_staged?logo=dart)](https://pub.dev/packages/arb_gen/score) -->

[![Dart Test](https://github.com/Awesome-T/arb_gen/actions/workflows/dart.yml/badge.svg)](https://github.com/Awesome-T/arb_gen/actions/workflows/dart.yml)

[![codecov](https://codecov.io/gh/Awesome-T/arb_gen/graph/badge.svg?token=K5SU9H0KE3)](https://codecov.io/gh/Awesome-T/arb_gen)

<!-- [![CI](https://github.com/Awesome-T/arb_gen/actions/workflows/test.yaml/badge.svg?branch=dev)](https://pub.dev/packages/arb_gen) -->
[![Buid status](https://github.com/Baseflow/flutter-geocoding/workflows/Geocoding/badge.svg)](https://github.com/Awesome-T/arb_gen/actions)

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Awesome-T/arb_gen/blob/dev/LICENSE)
<!-- [![CodeFactor](https://img.shields.io/codefactor/grade/github/alexeyinkin/dart-model-interfaces?style=flat-square)](https://www.codefactor.io/repository/github/alexeyinkin/dart-model-interfaces) -->
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
<!-- [![Support Chat Telegram](https://img.shields.io/badge/support%20chat-telegram-brightgreen)](https://ainkin.com/chat) -->

<!-- [![Support Chat Discord](https://img.shields.io/discord/295953187817521152.svg?style=flat-square&colorA=7289da&label=Chat%20on%20Discord)](https://ainkin.com/chat) -->
# ARB Gen

ARB Gen is a Dart package designed to simplify the translation and localization process in Flutter projects using ARB (Application Resource Bundle) files. It automates the generation of translated ARB files, allowing you to focus on the translation itself.

## Features

Automatic Translation: Translate your content from a base language to multiple target languages with ease.

Integration with Flutter: Easily integrate the generated translations into your Flutter project.

Flexible Configuration: Customize the translation process with a configuration file or command line arguments.

Dynamic Updates: Dynamically update your Flutter app with new translations without manual intervention.

## Installation

Add the following dependency to your pubspec.yaml file:

```yaml
dependencies:
  arb_gen: ^1.0.0
```

Then, run:

```bash
 flutter pub get
```

## Usage

1. Configuration

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

2. Run ARB Gen

Run the following command to execute the translation process:

```bash
dart arb.gen.dart
```

3. Integration with Flutter

If allAtOnce is set to false in your configuration, follow these steps to integrate the generated translations into your Flutter project:

3.1 Update pubspec.yaml

```yaml
flutter:
  generate: true

dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.17.0
```

3.2 Create l10n.yaml

```yaml
arb-dir: lib/l10n
template-arb-file: localization_en.arb
output-localization-file: app_localizations.dart
```

3.3 Run Flutter Pub Get

Run the following command to fetch the dependencies and generate the localized files:

```bash
flutter pub get
```

3.4 Move Generated Files Manually

Manually move the generated ARB files from the specified output folder (lib/l10n/ by default) to your project's localization folder.

```bash
mv generated_arb_files/* lib/l10n/
```

3.5 Update Pubspec.yaml for Incremental Builds

If you're manually moving files, consider updating the pubspec.yaml with the following commented-out section for incremental builds:

```yaml
# flutter:
#   generate: true
#   config:
#     arb-dir: lib/l10n
#     output-localization-file: app_localizations.dart
```

4. Run Flutter Pub Get (if not already done)

Run the following command again to ensure everything is up-to-date:

```bash
flutter pub get
```

This process is necessary when allAtOnce is set to false. If allAtOnce is true, all these steps happen automatically during the main execution.

Locale identifier | Description
----------------- | -----------
en | All English speakers (will translate all attributes to English)
en_US | English speakers in the United States of America
en_UK | English speakers in the United Kingdom
nl_NL | Dutch speakers in The Netherlands
nl_BE | Dutch speakers in Belgium

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/awesome_t#)
<a href="https://paypal.me/marvinperzi?country.x=AT&locale.x=de_DE"><img src="https://github.com/andreostrovsky/donate-with-paypal/raw/master/blue.svg" height="30"></a>

```
arb.gen
├── config.json
└── content.json
```

arb

```bash
├── arb.gen
├── build
│   └── 46ee22b4b1157a3e272358ccece3a368
├── ios
│   ├── Flutter
│   ├── Runner
│   │   ├── Assets.xcassets
│   │   │   ├── AppIcon.appiconset
│   │   │   └── LaunchImage.imageset
│   │   └── Base.lproj
│   ├── Runner.xcodeproj
│   │   ├── project.xcworkspace
│   │   │   └── xcshareddata
│   │   │       └── swiftpm
│   │   │           └── configuration
│   │   └── xcshareddata
│   │       └── xcschemes
│   ├── Runner.xcworkspace
│   │   ├── xcshareddata
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── shentsov1988gmail.com.xcuserdatad
│   └── RunnerTests
└── lib
    ├── l10n
    └── localization
```

The background color is `#ffffff` for light mode and `#000000` for dark mode.

This site was built using
[GitHub Pages](https://pages.github.com/).

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://myoctocat.com/assets/images/base-octocat.svg)

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.

<!-- This content will not appear in the rendered Markdown -->

- [x] #739
- [ ] <https://github.com/octo-org/octo-repo/issues/740>
- [ ] Add delight to the experience when all tasks are complete :tada:

{
  'af', // Afrikaans
  'am', // Amharic
  'ar', // Arabic
  'as', // Assamese
  'az', // Azerbaijani
  'be', // Belarusian
  'bg', // Bulgarian
  'bn', // Bengali Bangla
  'bs', // Bosnian
  'ca', // Catalan Valencian
  'cs', // Czech
  'cy', // Welsh
  'da', // Danish
  'de', // German
  'el', // Modern Greek
  'en', // English
  'es', // Spanish Castilian
  'et', // Estonian
  'eu', // Basque
  'fa', // Persian
  'fi', // Finnish
  'fil', // Filipino Pilipino
  'fr', // French
  'gl', // Galician
  'gsw', // Swiss German Alemannic Alsatian
  'gu', // Gujarati
  'he', // Hebrew
  'hi', // Hindi
  'hr', // Croatian
  'hu', // Hungarian
  'hy', // Armenian
  'id', // Indonesian
  'is', // Icelandic
  'it', // Italian
  'ja', // Japanese
  'ka', // Georgian
  'kk', // Kazakh
  'km', // Khmer Central Khmer
  'kn', // Kannada
  'ko', // Korean
  'ky', // Kirghiz Kyrgyz
  'lo', // Lao
  'lt', // Lithuanian
  'lv', // Latvian
  'mk', // Macedonian
  'ml', // Malayalam
  'mn', // Mongolian
  'mr', // Marathi
  'ms', // Malay
  'my', // Burmese
  'nb', // Norwegian Bokmål
  'ne', // Nepali
  'nl', // Dutch Flemish
  'no', // Norwegian
  'or', // Oriya
  'pa', // Panjabi Punjabi
  'pl', // Polish
  'ps', // Pushto Pashto
  'pt', // Portuguese
  'ro', // Romanian Moldavian Moldovan
  'ru', // Russian
  'si', // Sinhala Sinhalese
  'sk', // Slovak
  'sl', // Slovenian
  'sq', // Albanian
  'sr', // Serbian
  'sv', // Swedish
  'sw', // Swahili
  'ta', // Tamil
  'te', // Telugu
  'th', // Thai
  'tl', // Tagalog
  'tr', // Turkish
  'uk', // Ukrainian
  'ur', // Urdu
  'uz', // Uzbek
  'vi', // Vietnamese
  'zh', // Chinese
  'zu', // Zulu
};
