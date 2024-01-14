import 'dart:convert';

import '../../arb_gen.dart';
import '../i_translator.dart';

/// The `DeeplTranslaner` class is a concrete implementation of the
///  `ServiceTranslator` abstract class
/// specifically designed for DeepL translation service.
class DeeplTranslaner extends ServiceTranslator {
  /// Constructor for `DeeplTranslaner`.
  ///
  /// [apiKey] is the API key required for accessing the DeepL API.
  DeeplTranslaner(this.apiKey);

  @override

  /// The API key required for DeepL API.
  final String apiKey;

  @override

  /// Translates a text from a specified language to another language using DeepL API.
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

      final uri = Uri.parse('https://api.deepl.com/v2/translate');
      final headers = <String, String>{
        'Authorization': 'DeepL-Auth-Key $apiKey',
        'Content-Type': 'application/json',
      };
      final data = <String, Object>{
        'text': [source],
        'target_lang': to,
      };
      if (from != 'auto') data['source_lang'] = from;
      final result = await httpClient.makePost(uri, jsonEncode(data), headers);
      /* 
       * Example response
          {
            "translations": [
              {
                "detected_source_language": "EN",
                "text": "Hallo, Welt!"
              }
            ]
          }
        */
      final map = jsonDecode(result);
      return map['translations'][0]['text'] as String;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
