import 'dart:convert';
import '../../arb_gen.dart';
import '../i_translator.dart';

///
///
///
class OpenAiTranslator extends ServiceTranslator {
  /// Constructor for `OpenAiTranslator`.
  ///
  /// [apiKey] is the API key required for accessing the OpenAI API.
  OpenAiTranslator(this.apiKey);

  @override
  /// The API key required for OpenAI API.
  final String apiKey;

  @override
  /// Translates a text from a specified language to another language using OpenAI API.
  ///
  /// Returns the translated text.
  Future<String> translate(
    String source, {
    String from = 'auto',
    String to = 'en',
  }) async {
    try {
      final body = {
        // *  "model": "gpt-3.5-turbo",
        // *  "gpt-3.5-turbo-instruct"
        'model': 'gpt-3.5-turbo-1106',
        'response_format': <String, String>{
          'type': 'json_object',
        },
        'messages': <Map<String, String>>[
          <String, String>{
            'role': 'system',
            'content': 'You are a helpful assistant designed to output JSON.',
          },
          <String, String>{
            'role': 'user',
            // ignore: lines_longer_than_80_chars
            'content': 'Translate each sentence separated by SEPARATOR for app localization into $to:$source',
          }
        ],
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$$apiKey',
      };
      final uri = Uri.parse('https://api.openai.com/v1/chat/completions');
      final responseBody = await httpClient.makePost(uri, body, headers);
      final result = jsonDecode(responseBody) as Map<String, dynamic>;
      return result['text'] as String;
    } on FormatException catch (e) {
      throw FormatException('$e');
    }
  }
}
