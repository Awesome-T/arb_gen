import 'dart:convert';

import '../../arb_gen.dart';


///
/// Translate a single input
/// * Request doesn't specify the input language. Autodetection of the source
/// language is used instead.
/// * url: https://learn.microsoft.com/en-us/azure/ai-services/translator/reference/v3-0-translate#translate-a-single-input-with-language-autodetection
/// 
/// 
/// ```bash
/// curl -X POST "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=zh-Hans"
/// -H "Ocp-Apim-Subscription-Key: <client-secret>"
/// -H "Content-Type: application/json; charset=UTF-8"
/// -d "[{'Text':'Hello, what is your name?'}]"
/// ```
/// 
///  example responde
/// 
/// ```json 
/// [
///     {
///       "detectedLanguage": {"language": "en", "score": 1.0},
///        "translations":[
///            {"text": "你好, 你叫什么名字？", "to": "zh-Hans"}
///         ]
///     }
///`]
/// ```
/// 
class MsTranslator extends ServiceTranslator {
  /// Constructor for `MsTranslator`.
  ///
  /// [apiKey] is the API key required for accessing the Microsoft Translator API.
  MsTranslator(this.apiKey);

  @override
  /// The API key required for Microsoft Translator API.
  final String apiKey;

  @override
  /// Translates a text from a specified language to another language using Microsoft Translator API.
  ///
  /// Returns the translated text.
  Future<String> translate(
    String source, {
    String from = 'auto',
    String to = 'en',
  }) async {
    // for (final code in [from, to]) {
    //   if (!_languageList.contains(code)) throw LanguageNotSupportedException(code);
    // }
    try {
      final uri = Uri.parse('https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=$to');
      final headers = <String, String>{
        'Ocp-Apim-Subscription-Key': apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final requestBody = <String, dynamic>{'text': source};
      final jsonBody = jsonEncode(requestBody);
      final responseBody = await httpClient.makePost(uri, jsonBody, headers);
      final result = jsonDecode(responseBody) as List<dynamic>;
      final translatedText = (((result.first as Map)['translations'] as List<dynamic>)[0] as Map)['text'] as String;
      return translatedText;
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}
