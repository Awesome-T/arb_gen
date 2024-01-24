import 'dart:io';

import 'package:example/core/localyze/repo/lds/localize_ilds.dart';
import 'package:example/core/localyze/repo/params.dart';
import 'package:example/localization/langs.g.dart';
import 'package:flutter/foundation.dart';

/// The `ILocalizationRepo` interface defines methods for handling
/// localization-related operations.
abstract class ILocalizationRepo {
  ///
  const ILocalizationRepo();

  ///
  /// [LocalizationRepoImpl]
  ///
  factory ILocalizationRepo.impl({
    required ILDS prefs,
  }) =>
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
  /// Constructor for `LocalizationRepoImpl` that takes an `ILDS`
  /// instance and optional language mappings.
  const LocalizationRepoImpl({
    required ILDS prefs,
    Map<String, Map<String, String>> langs = LANGS,
  })  : _prefs = prefs,
        langs = langs;
  final ILDS _prefs;
  @override
  final Map<String, Map<String, String>> langs;
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
      final localeCode = Platform.localeName.substring(0, 2);
      final contains = langs.keys.contains(localeCode);
      if (contains) {
        return localeCode;
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
