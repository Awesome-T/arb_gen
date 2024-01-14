/// The `IcuParsingException` class represents an exception
/// thrown when there is an issue with ICU message format parsing.
class IcuParsingException implements Exception {
  const IcuParsingException(this.message);
  final String message;
}

/// The `ArbDataException` class represents an exception
/// thrown when there is an issue with ARB data format.
class ArbDataException implements Exception {
  const ArbDataException(this.message);
  final String message;
}

/// The `ConfigArgException` class represents an exception
/// thrown when there is an issue with configuration arguments.
class ConfigArgException implements Exception {
  const ConfigArgException(this.message);
  final dynamic message;
}

/// The `TranslationCodeException` class represents an exception
/// thrown when there is an issue with translation codes.
class TranslationCodeException implements Exception {
  const TranslationCodeException(this.message);
  final dynamic message;
}

/// The `LanguageNotSupportedException` class represents an exception
/// thrown when a language is not supported.
class LanguageNotSupportedException implements Exception {
  LanguageNotSupportedException({required String lang})
      : msg = '$lang is not a supported language.';
  final String msg;
}
