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

///
///
///
class Config {
  //
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
  ///
  /// * by default `class $L{}`
  final String? outputClass;

  /// path to the local service folder
  ///
  /// * `/lib/$outPutFolder`
  ///
  final String lDirName;

  /// name for .arb files
  ///  ```arbName```_languageCode.arb
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
  ///  * for example "arb.gen/content.json"
  String get pathToFile => 'arb.gen/content.json';

  /// output directory for all generated .arb files
  /// default foldeer for all .arb files  'lib/l10n'
  String get arbDir => 'lib/l10n';

  ///
  ///
  List<String> langs([
    Map<String, Map<String, String>> languageMap = FlutterSupportedLanguages,
  ]) {
    return languageMap.keys.toList();
  }

  /// This method is doing a good job of validating the configuration,
  /// ensuring that essential parameters are correctly set.
  void _chekSettingsAndContent() {
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
  ///
  void chechNameOfOutClass() {
    if (outputClass != null && !RegExp(r'^[a-zA-Z\D]{1}[_AZaz\S\d+]{0,}$', unicode: true).hasMatch(outputClass!)) {
      final msg = '`outputClass` name $outputClass is incorrect';
      stderr.write(msg);
      throw ConfigArgException(msg);
    }
  }

  ///
  /// * extension must be .json or .arb
  /// * "pathToFile": "arb.gen/content.json",
  void checkPathToFile() {
    if (!RegExp(r'.*\.(JSON|json|arb|ARB)$', unicode: true).hasMatch(pathToFile)) {
      final msg = 'extesion must be .json or .arb $pathToFile';
      stderr.write(msg);
      throw FileSystemException(msg);
    }
  }

  ///
  ///
  ///
  void checkArbName() {
    if (!RegExp(r'^[a-zA-Z]{1,}$', unicode: true).hasMatch(arbName)) {
      final msg = 'name of file  is not correct $arbName';
      stderr.write(msg);
      throw ConfigArgException(msg);
    }
  }

  ///
  void checkApiKeyOfService() {
    final notEqual = apiKey.runtimeType != translater.runtimeType;
    if (notEqual) {
      const msg = 'Both properties (apiKey and translater) must be specified or be null.';
      stderr.write(msg);
      throw const ConfigArgException(msg);
    }
  }

  ///  Если массив `_langCodes` длиннее, и тебе необходимо проверить,
  /// * что все элементы массива `translateTo` содержатся в массиве `_langCodes`
  void checkTargetLangs(List<String> suppurtedLangCodes) {
    final isNotConfirmCodes = !translateTo.toSet().every(suppurtedLangCodes.contains);
    if (isNotConfirmCodes) {
      final notSypportedCodes = translateTo.whereNot(suppurtedLangCodes.contains).toList();
      final msg = 'Exeprion: some language codes are wrong : $notSypportedCodes\n';
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
          : msg = 'Error preferredLanguage: $preferredLanguage must be in `translateTo` array';
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
    '${Directory.current.path}/arb.gen',
  );

  ///
  static final File _confog = File(
    '${_inDint.path}/config.json',
  );

  ///
  /// folder and config are exists
  ///
  static bool get isFileCofigExist => _inDint.existsSync() && _confog.existsSync();
}


// void main(List<String> args) {
//   final isNotConfirmCodes = !LangsTranslationService.keys.toSet().every(FlutterSupportedLanguages.keys.contains);
//   if (isNotConfirmCodes) {
//     final notSypportedCodes = LangsTranslationService.keys.whereNot(FlutterSupportedLanguages.keys.contains).toList();
//   final y=  LangsTranslationService.entries.takeWhile((value) =>
//         !notSypportedCodes.contains(  value.key),
//     );
//     final msg = 'Exeprion: some language codes are wrong : $notSypportedCodes\n$y';
//     stderr.write(msg);
//   }
// }
