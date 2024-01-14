import 'dart:convert';

import '../../arb_gen.dart';

/// The `YandexTranslator` class is a concrete implementation of the `ServiceTranslator` abstract class
/// specifically designed for Yandex Translate service.
///
///
///  url https://yandex.ru/dev/translate/doc/en/
///
///
/// ```bash
/// POST /api/v1.5/tr.json/translate?lang=en-ru&key=API-KEY HTTP/1.1
/// Host: translate.yandex.net
/// Accept: */*
/// Content-Length: 17
/// Content-Type: application/x-www-form-urlencoded
/// text=Hello World!
/// ```
///
///
/// responde
///
///
///
///```bash
/// HTTP/1.1 200 OK
/// Server: nginx
/// Content-Type: application/json; charset=utf-8
/// Content-Length: 68
/// Connection: keep-alive
/// Keep-Alive: timeout=120
/// X-Content-Type-Options: nosniff
/// Date: Thu, 31 Mar 2016 10:50:20 GMT
/// {
///    "code": 200,
///     "lang": "en-ru",
///     "text": [
///       "Здравствуй, Мир!"
///     ]
/// }
/// ```
///
class YandexTranslator extends ServiceTranslator {
  /// Constructor for `YandexTranslator`.
  ///
  /// [apiKey] is the API key required for accessing the Yandex Translate API.
  YandexTranslator(this.apiKey); // : super(_languageList);

  @override

  /// The API key required for Yandex Translate API.
  final String apiKey;

  @override

  /// Translates a text from a specified language to another language using Yandex Translate API.
  ///
  /// Returns the translated text.
  Future<String> translate(
    String source, {
    String from = 'auto',
    String to = 'en',
  }) async {
    try {
      // for (final code in [from, to]) {
      //   if (!_languageList.contains(code)) {
      //     throw LanguageNotSupportedException(code);
      //   }
      // }
      //  headers["Content-Type"] = "application/json"
      // * https://translate.yandex.net/api/v1.5/tr.json/translate
      final uri = Uri.parse(
          'https://translate.yandex.net/api/v1.5/tr.json/translate?key=$apiKey&text=$source&lang=$to');
      final makeGetResponse = await httpClient.makeGet(uri, null);
      final result = jsonDecode(makeGetResponse) as Map<String, dynamic>;
      return (result['text'] as List).first as String;
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}
