// ignore_for_file: lines_longer_than_80_chars

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
///
// kCupertinoSupportedLanguages
// kMaterialSupportedLanguages|
// kWidgetsSupportedLanguages

class Config {
  //
  Config._({
    required this.pathToFile,
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
  factory Config.load(Map<String, dynamic> data) {
    try {
      return Config._(
        pathToFile: data['pathToFile'] as String,
        preferredLanguage: data['preferredLanguage'] as String?,
        translateTo: List<String>.from(data['translateTo'] as List)
          ..map((e) => e.toLowerCase()).toSet().toList(),
        ignored: data['ignored'] == null
            ? <String>[]
            : List<String>.from(data['ignored'] as List),
        lDirName: (data['lDirName'] as String?) ?? 'localization',
        arbName: data['arbName'] as String? ?? 'localization',
        outputClass: (data['outputClass'] as String?) ?? r'$L',
        baseLanguage: data['baseLanguage'] as String?,
        translater: data['translater'] as String?,
        apiKey: data['apiKey'] as String?,
        allAtOnce: data['allAtOnce'] as bool? ?? true,
      );
    } on FormatException catch (e, t) {
      throw FormatException('$e\n$t');
    }
  }

  ///
  /// codes of languages for which localization is required.
  ///
  final List<String> translateTo;

  /// prefered language code
  /// * if `null` it'll be take first of `translateTo`
  ///
  final String? preferredLanguage;

  /// code of the original language used in the base file
  ///
  final String? baseLanguage;

  /// keys from the card that don't need to be transferred.
  /// Usually they are my own, for example - the name of the application.
  ///
  final List<String> ignored;

  /// Name of output class localization.
  /// * by default `class $L{}`
  final String? outputClass;

  /// The name of the directory where all dart localization
  /// files will reside.
  /// * by default `localization`
  /// * `lib/localization`
  final String lDirName;

  /// Filename for the source .arb files after translating.
  /// All files are located in the l10n directory.
  final String arbName;

  /// The name of the service to be translated.
  /// default is google translator, if it suits you,
  /// you can specify 'google' or leave the field empty.
  /// - 'deepl'
  /// - 'yandex'
  /// - 'google'
  /// - 'azure'
  /// - 'microsoft'
  /// - 'openAI'
  final String? translater;

  /// api key for the translation service.
  /// By default, translation is done by google translator,
  /// for which you do not need to specify an api key.
  final String? apiKey;

  /// - allAtOnce: flag to generate all translations at once
  final bool? allAtOnce;

  /// - pathToOriginSource: path to the original .arb/.json file,
  ///  * for example "arb.gen/foo/content.json"
  final String pathToFile;

  /// Directory where the .arb files will be stored.
  String get arbDir => 'lib/l10n';

  ///
  static const _initFolder = 'arb.gen';

  ///
  static const nameOfConfigFile = 'config.json';

  /// Get the list of language codes.
  List<String> langs([
    Map<String, Map<String, String>> languageMap = FlutterSupportedLanguages,
  ]) =>
      languageMap.keys.toList();

  /// Check the configuration settings and content.
  void _chekSettingsAndContent() {
    checkTargetLangs(langs());
    checkApiKeyOfService();
    checkArbName();
    checkPathToFile();
    chechNameOfOutClass();
  }

  /// Check the field `outputClass`.
  ///   * ``^[a-zA-Z\D]{1}[_AZaz\S\d+]{0,}$``
  ///   * `outputClass != null`
  void chechNameOfOutClass() {
    if (outputClass != null &&
        !RegExp(r'^[a-zA-Z\D]{1}[_AZaz\S\d+]{0,}$', unicode: true)
            .hasMatch(outputClass!)) {
      final msg = '`outputClass` name $outputClass is incorrect';
      stderr.write(msg);
      throw ConfigArgException(msg);
    }
  }

  /// Check the path to the file.
  /// * extension must be .json or .arb
  void checkPathToFile() {
    if (!RegExp(r'.*\.(JSON|json|arb|ARB)$', unicode: true)
        .hasMatch(pathToFile)) {
      final msg = 'extesion must be .json or .arb $pathToFile';
      stderr.write(msg);
      throw FileSystemException(msg);
    }
  }

  /// Check the .arb name.
  void checkArbName() {
    if (!RegExp(r'^[a-zA-Z]{1,}$', unicode: true).hasMatch(arbName)) {
      final msg = 'name of file  is not correct $arbName\n';
      stderr.write(msg);
      throw ConfigArgException(msg);
    }
  }

  /// Check the API key of the service.
  void checkApiKeyOfService() {
    final notEqual = apiKey != translater;
    if (notEqual) {
      const msg =
          'Both properties (apiKey and translater) must be specified or be null.';
      stderr.write(msg);
      throw const ConfigArgException(msg);
    }
  }

  /// Check the target languages.
  /// -  If the `_langCodes` array is longer, and you need to verify that
  /// -  all elements of the `translateTo` array are contained in the `_langCodes` array.
  void checkTargetLangs(List<String> suppurtedLangCodes) {
    final isNotConfirmCodes =
        !translateTo.toSet().every(suppurtedLangCodes.contains);
    if (isNotConfirmCodes) {
      final notSypportedCodes =
          translateTo.whereNot(suppurtedLangCodes.contains).toList();
      final msg =
          'Exeprion: some language codes are wrong : $notSypportedCodes\n';
      stderr.write(msg);

      throw ConfigArgException(msg);
    }
    //
    if (baseLanguage != null && !suppurtedLangCodes.contains(baseLanguage)) {
      final msg = 'Error baseLanguage: $baseLanguage  is not valid';
      stderr.write(msg);
      throw ConfigArgException(msg);
    }
    //
    if (preferredLanguage != null && !translateTo.contains(preferredLanguage)) {
      late String msg;
      !suppurtedLangCodes.contains(preferredLanguage)
          ? msg =
              'Error preferredLanguage: $preferredLanguage  is not valid and this code must be in `translateTo` array'
          : msg =
              'Error preferredLanguage: $preferredLanguage must be in `translateTo` array';
      stderr.write(msg);
      throw ConfigArgException(msg);
    }
    //
    if (translateTo.isEmpty) {
      const msg = 'key translateTo not exist or values is null';
      stderr.write(msg);
      throw const ConfigArgException(msg);
    }
  }

  /// directory where settings and content for
  /// translation are located. ```arb.gen```
  static final Directory _inDint = Directory(
    <String>[Directory.current.path, _initFolder].join(
      Platform.pathSeparator,
    ),
  );

  /// Configuration file.
  static final File _configFile = File(
    <String>[
      _inDint.path,
      nameOfConfigFile,
    ].join(
      Platform.pathSeparator,
    ),
  );

  /// folder and config are exists
  static bool get isFileCofigExist =>
      _inDint.existsSync() && _configFile.existsSync();
}
