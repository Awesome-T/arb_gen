// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, constant_identifier_names, lines_longer_than_80_chars
import 'dart:io';
import 'package:collection/collection.dart';
import 'constraints.dart';
import 'errors.dart';

/// Configuration for the builder
/// The file must be placed at "arb.gen/config.json"
/// - translateTo: array with language codes
/// - ignored: list of keys to be ignored during translation
/// - pathToOriginSource: path to the original .arb/.json file, for example "arb.gen/content.json"
/// - pLocalServiceFolder: path to the local service folder
/// - outputFolder: output directory for all generated .arb files
/// - arbName: name for .arb files
/// - baseLanguage: code of the original language used in the base file
/// - translater: translator service to use
/// - apiKey: private API key
/// - allAtOnce: flag to generate all translations at once
/// The file must be placed at "arb.gen/config.json" localization
// kCupertinoSupportedLanguages|kMaterialSupportedLanguages|kWidgetsSupportedLanguages

class Config {
  /// language codes for translations
  final List<String> translateTo;

  /// prefered language code
  /// * if `null` it'll be take first of `translateTo`
  final String? preferredLanguage;

  /// - ignored: list of keys to be ignored during translation
  final List<String> ignored;

  /// - pathToOriginSource: path to the original .arb/.json file,
  ///  * for example "arb.gen/content.json"
  String get pathToFile => 'arb.gen/content.json';

  /// Name of output class localization
  /// * by default `class $L{}`
  final String? outputClass;

  /// path to the local service folder
  /// * `/lib/$outPutFolder`
  final String lDirName;

  /// output directory for all generated .arb files
  /// default foldeer for all .arb files   'lib/l10n'
  String get arbDir => 'lib/l10n';

  /// name for .arb files
  ///  ```arbName```_languageCode.arb
  final String arbName;

  /// code of the original language used in the base file
  final String? baseLanguage;

  /// service to use
  final String? translater;

  /// private API key for translation service
  final String? apiKey;

  /// - allAtOnce: flag to generate all translations at once
  final bool? allAtOnce;

  Config._({
    required this.outputClass,
    required this.translateTo,
    required this.ignored,
    required this.lDirName,
    required this.arbName,
    this.translater,
    this.preferredLanguage,
    this.baseLanguage,
    this.apiKey,
    this.allAtOnce = true,
  }) {
    _chekSettingsAndContent();
  }

  ///
  ///
  List<String> langs([Map<String, Map<String, String>> languageMap = LANGS]) {
    return languageMap.keys.toList();
  }

  /// This method is doing a good job of validating the configuration,
  /// ensuring that essential parameters are correctly set.
  void _chekSettingsAndContent() {

    //  Если массив `_langCodes` длиннее, и тебе необходимо проверить,
    // * что все элементы массива `translateTo` содержатся в массиве `_langCodes`
    checkTargetLangs(langs());
    checkApiKeyOfService();
    checkArbName();
    checkPathToFile();
    chechNameOfOutClass();
  }

  /// check  field `outputClass`
  ///
  ///   * ``^[a-zA-Z\D]{1}[_AZaz\S\d+]{0,}$``
  ///   * `outputClass != null`
  void chechNameOfOutClass() {
    if (outputClass != null && !RegExp(r'^[a-zA-Z\D]{1}[_AZaz\S\d+]{0,}$', unicode: true).hasMatch(outputClass!)) {
      final msg = '`outputClass` name $outputClass is incorrect';
      print(msg);
      throw ConfigArgException(msg);
    }
  }

  ///
  /// * extension must be .json or .arb
  /// * "pathToFile": "arb.gen/content.json",
  void checkPathToFile() {
    if (!RegExp(r'.*\.(JSON|json|arb|ARB)$', unicode: true).hasMatch(pathToFile)) {
      final msg = 'extesion must be .json or .arb $pathToFile';
      print(msg);
      throw FileSystemException(msg);
    }
  }

  ///
  ///
  ///
  void checkArbName() {
    if (!RegExp(r'^[a-zA-Z]{1,}$', unicode: true).hasMatch(arbName)) {
      final msg = 'name of file  is not correct $arbName';
      print(msg);
      throw ConfigArgException(msg);
    }
  }

  ///
  void checkApiKeyOfService() {
    final notEqual = apiKey.runtimeType != translater.runtimeType;
    if (notEqual) {
      const msg = 'Both properties (apiKey and translater) must be specified or be null.';
      print(msg);
      throw const ConfigArgException(msg);
    }
  }

  ///  Если массив `_langCodes` длиннее, и тебе необходимо проверить,
  /// * что все элементы массива `translateTo` содержатся в массиве `_langCodes`
  void checkTargetLangs(List<String> suppurtedLangCodes) {
    final isNotConfirmCodes = !translateTo.toSet().every(suppurtedLangCodes.contains);
    if (isNotConfirmCodes) {
      final notSypportedCodes = translateTo.whereNot(suppurtedLangCodes.contains).toList();
      final msg = 'Exeprion: some language codes are wrong : $notSypportedCodes';
      print(msg);
      throw ConfigArgException(msg);
    }
    //
    if (baseLanguage != null && !suppurtedLangCodes.contains(baseLanguage)) {
      final msg = 'Error baseLanguage: $baseLanguage  is not valid';
      print(msg);
      throw ConfigArgException(msg);
    }
    //
    if (preferredLanguage != null && !translateTo.contains(preferredLanguage)) {
      late String msg;
      !suppurtedLangCodes.contains(preferredLanguage)
          ? msg =
              'Error preferredLanguage: $preferredLanguage  is not valid and this code must be in `translateTo` array'
          : msg = 'Error preferredLanguage: $preferredLanguage must be in `translateTo` array';
      print(msg);
      throw ConfigArgException(msg);
    }
    //
    if (translateTo.isEmpty) {
      const msg = 'key translateTo not exist or values is null';
      print(msg);
      throw const ConfigArgException(msg);
    }
  }

  /// directory for settings ```arb.gen```
  static final Directory _inDint = Directory('${Directory.current.path}/arb.gen');

  ///
  static final File _confog = File('${_inDint.path}/config.json');

  /// folder and config are exists
  static bool get isFileCofigExist => _inDint.existsSync() && _confog.existsSync();

  ///
  factory Config.load(Map<String, dynamic> data) {
    try {
      return Config._(
        preferredLanguage: data['preferredLanguage'] as String?,
        translateTo: List<String>.from(data['translateTo'] as List)..map((e) => e.toLowerCase()).toSet().toList(),
        ignored: data['ignored'] == null ? <String>[] : List<String>.from(data['ignored'] as List),
        lDirName: (data['localization'] as String?) ?? 'localization',
        baseLanguage: data['baseLanguage'] as String?,
        translater: data['translater'] as String?,
        apiKey: data['apiKey'] as String?,
        arbName: data['arbName'] as String? ?? 'localization',
        outputClass: (data['outputClass'] as String?) ?? r'$L',
        allAtOnce: data['allAtOnce'] as bool? ?? true,
      );
    } on FormatException catch (e, t) {
      throw FormatException('$e\n$t');
    }
    //  on ConfigArgException catch (e) {
    //   throw ConfigArgException(e);
    // }
  }
}

// const Set<String> kMaterialSupportedLanguages = {
//   'af', // Afrikaans
//   'am', // Amharic
//   'ar', // Arabic
//   'as', // Assamese
//   'az', // Azerbaijani
//   'be', // Belarusian
//   'bg', // Bulgarian
//   'bn', // Bengali Bangla
//   'bs', // Bosnian
//   'ca', // Catalan Valencian
//   'cs', // Czech
//   'cy', // Welsh
//   'da', // Danish
//   'de', // German
//   'el', // Modern Greek
//   'en', // English
//   'es', // Spanish Castilian
//   'et', // Estonian
//   'eu', // Basque
//   'fa', // Persian
//   'fi', // Finnish
//   'fil', // Filipino Pilipino
//   'fr', // French
//   'gl', // Galician
//   'gsw', // Swiss German Alemannic Alsatian
//   'gu', // Gujarati
//   'he', // Hebrew
//   'hi', // Hindi
//   'hr', // Croatian
//   'hu', // Hungarian
//   'hy', // Armenian
//   'id', // Indonesian
//   'is', // Icelandic
//   'it', // Italian
//   'ja', // Japanese
//   'ka', // Georgian
//   'kk', // Kazakh
//   'km', // Khmer Central Khmer
//   'kn', // Kannada
//   'ko', // Korean
//   'ky', // Kirghiz Kyrgyz
//   'lo', // Lao
//   'lt', // Lithuanian
//   'lv', // Latvian
//   'mk', // Macedonian
//   'ml', // Malayalam
//   'mn', // Mongolian
//   'mr', // Marathi
//   'ms', // Malay
//   'my', // Burmese
//   'nb', // Norwegian Bokmål
//   'ne', // Nepali
//   'nl', // Dutch Flemish
//   'no', // Norwegian
//   'or', // Oriya
//   'pa', // Panjabi Punjabi
//   'pl', // Polish
//   'ps', // Pushto Pashto
//   'pt', // Portuguese
//   'ro', // Romanian Moldavian Moldovan
//   'ru', // Russian
//   'si', // Sinhala Sinhalese
//   'sk', // Slovak
//   'sl', // Slovenian
//   'sq', // Albanian
//   'sr', // Serbian
//   'sv', // Swedish
//   'sw', // Swahili
//   'ta', // Tamil
//   'te', // Telugu
//   'th', // Thai
//   'tl', // Tagalog
//   'tr', // Turkish
//   'uk', // Ukrainian
//   'ur', // Urdu
//   'uz', // Uzbek
//   'vi', // Vietnamese
//   'zh', // Chinese
//   'zu', // Zulu
// };

const List<String> supportedLanguagesGoogle = [
  'af',
  'sq',
  'am',
  'ar',
  'hy',
  'az',
  'eu',
  'be',
  'bn',
  'bs',
  'bg',
  'ca',
  'ceb',
  'ny',
  'zh-CN',
  'zh-TW',
  'co',
  'hr',
  'cs',
  'da',
  'nl',
  'en',
  'eo',
  'et',
  'tl',
  'fi',
  'fr',
  'fy',
  'gl',
  'ka',
  'de',
  'el',
  'gu',
  'ht',
  'ha',
  'haw',
  'iw',
  'he',
  'hi',
  'hmn',
  'hu',
  'is',
  'ig',
  'id',
  'ga',
  'it',
  'ja',
  'jw',
  'kn',
  'kk',
  'km',
  'ko',
  'ku',
  'ky',
  'lo',
  'la',
  'lv',
  'lt',
  'lb',
  'mk',
  'mg',
  'ms',
  'ml',
  'mt',
  'mi',
  'mr',
  'mn',
  'my',
  'ne',
  'no',
  'ps',
  'fa',
  'pl',
  'pt',
  'pa',
  'ro',
  'ru',
  'sm',
  'gd',
  'sr',
  'st',
  'sn',
  'sd',
  'si',
  'sk',
  'sl',
  'so',
  'es',
  'su',
  'sw',
  'sv',
  'tg',
  'ta',
  'tt',
  'te',
  'th',
  'tr',
  'tk',
  'uk',
  'ur',
  'ug',
  'uz',
  'vi',
  'cy',
  'xh',
  'yi',
  'yo',
  'zu',
];

const List<String> supportedFlutter = [
  'af', 'am', 'ar', 'as', 'az', 'be', 'bg', 'bn', 'bs', 'ca', 'cs', 'cy', 'da', 'de', 'el', 'en', 'es', 'et',
  'eu', 'fa', 'fi', 'fil', 'fr', 'gl', 'gsw', 'gu', 'he', 'hi', 'hr', 'hu', 'hy', 'id', 'is', 'it', 'ja', 'ka',
  'kk', 'km', 'kn', 'ko', 'ky', 'lo', 'lt', 'lv', 'mk', 'ml', 'mn', 'mr', 'ms', 'my', 'nb', 'ne', 'nl', 'no',
  'or', 'pa', 'pl', 'ps', 'pt', 'ro', 'ru', 'si', 'sk', 'sl', 'sq', 'sr', 'sv', 'sw', 'ta', 'te', 'th', 'tl',
  'tr', 'uk', 'ur', 'uz', 'vi', 'zh', 'zu',
  // 'af', 'sq', 'am', 'ar', 'hy', 'az', 'eu', 'be', 'bn', 'bs', 'ca', 'cs', 'cy', 'da', 'de', 'el', 'en', 'eo',
  // 'et', 'tl', 'fi', 'fr', 'fy', 'gl', 'ka', 'de', 'el', 'gu', 'ht', 'ha', 'haw', 'iw', 'he', 'hi', 'hmn', 'hu',
  // 'is', 'ig', 'id', 'ga', 'it', 'ja', 'jw', 'kn', 'kk', 'km', 'ko', 'ku', 'ky', 'lo', 'la', 'lv', 'lt', 'lb',
  // 'mk', 'mg', 'ms', 'ml', 'mt', 'mi', 'mr', 'mn', 'my', 'ne', 'no', 'ps', 'fa', 'pl', 'pt', 'pa', 'ro', 'ru',
  // 'sm', 'gd', 'sr', 'st', 'sn', 'sd', 'si', 'sk', 'sl', 'so', 'es', 'su', 'sw', 'sv', 'tg', 'ta', 'tt', 'te',
  // 'th', 'tr', 'tk', 'uk', 'ur', 'ug', 'uz', 'vi', 'cy', 'xh', 'yi', 'yo', 'zu',
];

// void main() {
//   // final differences = supportedLanguagesGoogle
//   //     .where((code) => !supportedFlutter.contains(code))
//   //     .toList()
//   //     .map((e) => jsonEncode(e))
//   //     .toList();
//   // print("Различия в языковых кодах:");
//   // print(differences);
// }

///
final k = {
  'ceb': {'Cebuano': 'Cebuano'},
  'ny': {'Chichewa': 'Chichewa'},
  'zh-CN': {'Chinese (Simplified)': '中文(简体)'},
  'zh-TW': {'Chinese (Traditional)': '中文(繁體)'},
  'co': {'Corsican': 'Corsican'},
  'eo': {'Esperanto': 'Esperanto'},
  'fy': {'Frisian': 'Frisian'},
  'ht': {'Haitian Creole': 'Haitian Creole'},
  'ha': {'Hausa': 'Hausa'},
  'haw': {'Hawaiian': 'Hawaiian'},
  'iw': {'Hebrew': 'العبرية'},
  'hmn': {'Hmong': 'Hmong'},
  'ig': {'Igbo': 'Igbo'},
  'ga': {'Irish': 'Irish'},
  'jw': {'Javanese': 'Javanese'},
  'ku': {'Kurdish': 'Kurdish'},
  'la': {'Latin': 'Latin'},
  'lb': {'Luxembourgish': 'Luxembourgish'},
  'mg': {'Malagasy': 'Malagasy'},
  'mt': {'Maltese': 'Maltese'},
  'mi': {'Maori': 'Maori'},
  'sm': {'Samoan': 'Samoan'},
  'gd': {'Scots Gaelic': 'Scots Gaelic'},
  'st': {'Sesotho': 'Sesotho'},
  'sn': {'Shona': 'Shona'},
  'sd': {'Sindhi': 'Sindhi'},
  'so': {'Somali': 'Somali'},
  'su': {'Sundanese': 'Sundanese'},
  'tg': {'Tajik': 'Tajik'},
  'tt': {'Tatar': 'Tatar'},
  'tk': {'Turkmen': 'Turkmen'},
  'ug': {'Uighur': 'Uighur'},
  'xh': {'Xhosa': 'Xhosa'},
  'yi': {'Yiddish': 'Yiddish'},
  'yo': {'Yoruba': 'Yoruba'},
};
