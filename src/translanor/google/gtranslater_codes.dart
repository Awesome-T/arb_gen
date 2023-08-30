import 'dart:async';
import 'dart:convert' show jsonDecode;

import '../i_translator.dart';

/// The `GoogleTS` class is a concrete implementation of the `ServiceTranslator` abstract class
/// specifically designed for Google Translate service.
class GoogleTS extends ServiceTranslator {
  /// Constructor for `GoogleTS`.
  const GoogleTS();

  @override
  /// Translates a text from a specified language to another language using Google Translate API.
  ///
  /// Returns the translated text.
  Future<String> translate(
    String source, {
    String from = 'auto',
    String to = 'en',
  }) async {
    final parameters = <String, String>{
      'client': 'gtx',
      'sl': from,
      'tl': to,
      'hl': to,
      'dt': 't',
      'ie': 'UTF-8',
      'oe': 'UTF-8',
      'otf': '1',
      'ssel': '0',
      'tsel': '0',
      'kc': '7',
      'tk': _TGen().generateToken(source),
      'q': source,
    };

    final uri = Uri.https(
      'translate.googleapis.com',
      '/translate_a/single',
      parameters,
    );

    final data = await httpClient.makeGet(uri, null);

    final arrays = jsonDecode(data) as List<dynamic>?;

    if (arrays == null) {
      const message = "Error: Can't parse json data";
      print(message);
      throw const FormatException(message);
    }

    late List<List<dynamic>> translatedData;
    late String? fromCode;
    for (var i = 0; i < arrays.length; i++) {
      if (i == 0) translatedData = List<List<dynamic>>.from(arrays[i] as List);
      if (i == 2) fromCode = arrays[i] as String?;
    }

    final buff = StringBuffer();

    for (var c = 0; c < translatedData.length; c++) {
      buff.write(translatedData[c][0]);
    }

    if (from == 'auto' && from != to) {
      from = fromCode ?? from;
      if (from == to) {
        from = 'auto';
      }
    }

    final translated = buff.toString();
    buff.clear();
    return translated;
  }

  @override
  /// Returns `null` for the API key since Google Translate API doesn't require an API key for basic usage.
  String? get apiKey => null;
}

/// The `_TGen` class is responsible for generating a token used in Google Translate API URLs.
class _TGen {
  /// Generate and return a token.
  String generateToken(String text) => tokenGen(text);

  /// Generate a valid Google Translate request token.
  ///
  /// [a] is the text to translate.
  String tokenGen(dynamic a) {
    final tkk = TKK();
    final b = tkk[0];
    final d = <num>[];

    for (var f = 0; f < a.toString().length; f++) {
      var g = a.toString().codeUnitAt(f);
      if (128 > g) {
        d.add(g);
      } else {
        if (2048 > g) {
          d.add(g >> 6 | 192);
        } else {
          if (55296 == (g & 64512) &&
              f + 1 < a.toString().length &&
              56320 == (a.toString().codeUnitAt(f + 1) & 64512)) {
            g = 65536 + ((g & 1023) << 10) + (a.toString().codeUnitAt(++f) & 1023);
            d
              ..add(g >> 18 | 240)
              ..add(g >> 12 & 63 | 128);
          } else {
            d.add(g >> 12 | 224);
          }
          d.add(g >> 6 & 63 | 128);
        }
        d.add(g & 63 | 128);
      }
    }

    a = b;

    for (var e = 0; e < d.length; e++) {
      if (a is String) {
        a = int.parse(a) + d[e];
      } else {
        a += d[e];
      }
      a = wr(a, '+-a^+6');
    }

    a = wr(a, '+-3^+b+-f');

    a ^= tkk[1] != null ? tkk[1] + 0 : 0;

    if (0 > (a as int)) a = (a & 2147483647) + 2147483648;
    a %= 1E6;
    a = (a as double).round();

    return '$a.${a ^ int.parse(b as String)}';
  }

  List TKK() => [
        '406398',
        (561666268 + 1526272306),
      ];

  int wr(dynamic a, dynamic b) {
    var d;
    try {
      for (var c = 0; c < b.toString().length - 2; c += 3) {
        d = b[c + 2];
        d = 'a'.codeUnitAt(0) <= d.toString().codeUnitAt(0)
            ? (d[0].toString().codeUnitAt(0)) - 87
            : int.parse(d as String);
        if ('+' == b[c + 1]) {
          d = unsignedRightShift(a as int, d as int);
        } else {
          d = a << d;
        }
        a = '+' == b[c] ? (a + (d as int) & 4294967295) : a ^ d;
      }
      return a as int;
    } on Error {
      rethrow;
    }
  }

  int unsignedRightShift(int a, int b) {
    int m;
    if (b >= 32 || b < -32) {
      m = (b / 32) as int;
      b = b - (m * 32);
    }

    if (b < 0) {
      b = 32 + b;
    }

    if (b == 0) {
      return ((a >> 1) & 0x7fffffff) * 2 + ((a >> b) & 1);
    }

    if (a < 0) {
      a = a >> 1;
      a &= 2147483647;
      a |= 0x40000000;
      a = a >> (b - 1);
    } else {
      a = a >> b;
    }

    return a;
  }
}
