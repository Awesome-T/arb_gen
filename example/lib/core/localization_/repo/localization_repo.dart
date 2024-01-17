import 'dart:io';

import 'package:example/core/localization_/repo/lds/localize_ilds.dart';
import 'package:example/core/localization_/repo/params.dart';
import 'package:flutter/foundation.dart';

import '../../../localization/langs.g.dart';

/// The `ILocalizationRepo` interface defines methods for handling
/// localization-related operations.
abstract class ILocalizationRepo {
  const ILocalizationRepo();

  ///
  /// [LocalizationRepoImpl]
  ///
  factory ILocalizationRepo.impl(
          {required ILDS prefs, Map<String, Map<String, String>>? langs}) =>
      LocalizationRepoImpl(prefs: prefs);

  ///
  /// Returns the supported language mappings.
  ///
  Map<String, Map<String, String>> get langs;

  /// Loads the language code based on the provided parameters.
  ///
  /// Returns the loaded language code, or `null` if not found.
  Future<String?> loadLandCode(LoadLocaleUCParam param);

  /// Updates the language code based on the provided parameters.
  Future<void> udateLangCode(UpdateLocaleUCParam param);
}

/// The `LocalizationRepoImpl` class implements the `ILocalizationRepo`
/// interface for localization operations.
base class LocalizationRepoImpl implements ILocalizationRepo {
  final ILDS _prefs;
  final Map<String, Map<String, String>> langs;

  /// Constructor for `LocalizationRepoImpl` that takes an `ILDS`
  /// instance and optional language mappings.
  const LocalizationRepoImpl({
    required ILDS prefs,
    Map<String, Map<String, String>> langs = LANGS,
  })  : _prefs = prefs,
        langs = langs;
  final String _code = 'landgCode';

  /// Loads the language code based on the provided parameters.
  ///
  /// Returns the loaded language code, or `null` if not found.
  @override
  Future<String?> loadLandCode(LoadLocaleUCParam param) async {
    final code = await _prefs.read(_code);
    if (code != null) {
      return code;
    }
    if (!kIsWeb) {
      final _localeCode = Platform.localeName.substring(0, 2);
      final _contains = langs.keys.contains(_localeCode);
      if (_contains) {
        return _localeCode;
      }
      return null;
    } else {
      return null;
    }
  }

  /// Updates the language code based on the provided parameters.
  @override
  Future<void> udateLangCode(UpdateLocaleUCParam param) async {
    await _prefs.createOrUpdate(_code, param.code);
  }
}
