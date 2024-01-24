// ignore_for_file: lines_longer_than_80_chars
import '../util/errors.dart';
import 'client_http.dart';
import 'deepl/deepl_translaner.dart';
import 'google/gtranslater_codes.dart';
import 'ms/ms_translator.dart';
import 'open_ai/open_ai_translator.dart';
import 'yandex/yandex_translator.dart';

/// The `ServiceTranslator` abstract class provides a common
/// interface for various translation services.
abstract class ServiceTranslator {
  /// Constructor for `ServiceTranslator` that takes an optional
  /// `httpClient` parameter.
  const ServiceTranslator([
    this.httpClient = const ClientHttp(),
  ]);

  /// The HTTP client used for making translation service requests.
  final IHttpClient httpClient;

  // NOTE: Uncomment the following line if the `ILanguageList` interface is defined.
  // final ILanguageList languageList;

  /// Retrieves the API key for the translation service.
  String? get apiKey;

  /// Translates a text from a specified language to one or more target languages.
  ///
  /// Returns a stream of translation results with data and language information.
  Stream<({String data, String lang})> translations(
    String data,
    List<String> to,
  ) async* {
    for (final i in to) {
      yield (data: await translate(data, to: i), lang: i);
    }
  }

  /// Translates text from a source language to a target language.
  ///
  /// The source language is detected automatically unless specified.
  /// Returns the translated text.
  Future<String> translate(
    String source, {
    String from = 'auto',
    String to = 'en',
  });

  /// Selects and returns an instance of `ServiceTranslator` based on
  /// the provided type and API key.
  ///
  /// Supported types include 'deepl', 'yandex', 'azure' or 'microsoft', 'openAI'.
  static ServiceTranslator select(
    String? type,
    String? apiKey,
  ) {
    if (type != null && apiKey != null) {
      switch (type) {
        case 'deepl':
          return DeeplTranslaner(apiKey);
        case 'yandex':
          return YandexTranslator(apiKey);
        case 'azure' || 'microsoft':
          return MsTranslator(apiKey);
        case 'openAI':
          return OpenAiTranslator(apiKey);
        case 'google':
          return const GoogleTS();
        default:
          throw TranslationCodeException('''
Code of the translator is not recognized: $type
''');
      }
    }
    return const GoogleTS();
  }
}
