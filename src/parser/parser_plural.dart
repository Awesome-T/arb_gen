import 'dart:io';

import '../util/errors.dart';
import 'i_innerparser.dart';
import 'i_parser.dart';
import 'types_of_content.dart';

///
///``{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}``
/// * group(1) - count
// ignore: constant_identifier_names
const String _R_PLURAL =
    r'{\s*(\w+)\s*,\s*plural,\s*((?:[^{}]+|\{(?:[^{}]+|\{[^{}]*\})*\})*)}';

///
///
/// * "{countPlaceholder, plural, =0{message0} =1{message1} =2{message2} few{messageFew} many{messageMany} other{messageOther}}"
class PluralParser extends IParset<PuralArb> {
  PluralParser(PluralInnerParser pluralInnerParser, [String patern = _R_PLURAL])
      : _innerParser = pluralInnerParser,
        super(RegExp(patern));

  final PluralInnerParser _innerParser;

  @override
  Map<String, dynamic> toArb(
    PuralArb parsedChank,
    List<String> translatedChank,
    String key,
  ) {
    assert(translatedChank.isNotEmpty, ' no translations');
    try {
      // *
      final counVariants = parsedChank.source.length;
      // *
      final placeholders = parsedChank.placeholders ?? [];
      // *
      final translatedSublist =
          translatedChank.getRange(0, counVariants).toList();
      //
      final keys = parsedChank.source.entries
          .map(
            (MapEntry<String, String> e) => e.key,
          )
          .toList();
      final variants = _innerParser.toVariants(
        translatedSublist,
        placeholders,
        keys,
      );
      //
      final translatedIcuStr =
          '{${parsedChank.placeholders?.first},${IcuKeyWord.plural.name},$variants}';
      //
      final arbTranslated = <String, dynamic>{key: translatedIcuStr};
      translatedChank.length == (parsedChank.source.entries.length)
          ? translatedChank.clear()
          : translatedChank.removeRange(0, parsedChank.source.entries.length);
      return arbTranslated;
    } on Exception catch (e) {
      throw Exception('''$e''');
    }
  }

  @override
  String toSingleStr(MapEntry<String, PuralArb> entry) {
    final buff = StringBuffer();
    entry.value.source.values.cast<String>().forEach(buff.writeln);
    final result = buff.toString();
    buff.clear();
    return result;
  }

  @override
  Map<String, PuralArb>? fromArb(MapEntry<String, dynamic> entry) {
    try {
      final match = maatchForStr(entry);
      if ((match?.groupCount ?? 0) > 0) {
//
        final str = match!.group(match.groupCount) ?? '';
        //
        final data = _innerParser.parceInnerData(str);
        //
        final mainPlaceholder = match.group(1)!;
        //  put the main placeholder into an array.
        data.placeholders.add(mainPlaceholder);
        //
        final result = <String, PuralArb>{
          entry.key: PuralArb(
            data.source,
            data.placeholders,
          ),
        };
        return result;
      }
      return null;
    } on IcuParsingException catch (e, trace) {
      throw IcuParsingException('$e\ntrace: $trace');
    }
  }
}

///
///
///
class PluralInnerParser implements IInnerParser {
  const PluralInnerParser();

  ///
  /// ``
  ///     g(1) - one  g(3) - You have 1 new message
  ///     one{You have 1 new message}
  ///     g(1) - other  g(3) - You have {count} new messages
  ///     other{You have {count} new messages}
  /// ``
  @override
  String get patern =>
      r'([а-яА-ЯA-Za-z0-9_=]+)(\s+){0,}(\{(?:[^{}]*\{[^{}]*\}[^{}]*|[^{}]+)?\})+';

  // * r'([а-яА-ЯA-Za-z0-9_=]+)(\s+){0,}(\{(?:[^{}]*\{[^{}]*\}[^{}]*|[^{}]+)?\})+',

  /// Parse single string with variants
  /// into different chank
  ///  called in `fromArb()`
  /// *   Example
  /// *   "zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}"
  /// *   {group(1):group(3)}
  ///
  /// ICU ``select`` or ``plural`` must contain `other`  word
  ///
  @override
  ({
    Map<String, String> source,
    List<String> placeholders,
  }) parceInnerData(String data) {
    //
    final source = <String, String>{};
    //
    final regExpMatcheis = RegExp(patern).allMatches(data);
    // additional placeholders can be found in this cycle.
    for (final m in regExpMatcheis) {
      // variant in curly brackets.
      // `{Some data are placed here}`
      final wittBrackets = m.group(3)!;
      // variant wo curly brackets.
      final woBrackets =
          wittBrackets.substring(1, wittBrackets.length - 1).trim();
      //
      source['${m.group(1)}'] = woBrackets;
    }
    final result = (source: source, placeholders: <String>[]);
    //
    final fd = result.source;

    hasOtherKeyword(fd);

    return result;
  }

  ///
  ///
  void hasOtherKeyword(Map<String, String> fd) {
    const otherKyeWord = 'other';
    final hasOtherKeyword = fd.keys.contains(otherKyeWord) ||
        fd.keys.contains(otherKyeWord.toLowerCase()) ||
        fd.keys.contains(otherKyeWord.toUpperCase());
    if (!hasOtherKeyword) {
      final msg =
          '''Exception: key ${fd.keys.toList()} - argument option must have `${otherKyeWord.toLowerCase()}` keyword clause ''';
      stderr.write(msg);
      throw IcuParsingException(msg);
    }
  }

  ///
  ///
  String toVariants(
    List<String> translatedSublist,
    List<String> placeholders,
    List<String> keys,
  ) {
    try {
      final buff = StringBuffer();
      for (var y = 0; y < translatedSublist.length; y++) {
        var valueInBrackets = '';
        if (placeholders.isNotEmpty) {
          // Counter to track the current position in the placeholder array
          var indx = 0;
          // called for each match within curly braces {}
          String replaceCallback(Match match) {
            // Ensure that currentIndex does not exceed the bounds of `replacementList`
            // Return the current value from replacementList and increment indx
            if (indx < placeholders.length) return '${{placeholders[indx++]}}';
            // If indx exceeds the bounds of _placeholders, return the original value
            return match.group(0)!;
          }

          // Apply the function to each match within curly braces {}
          final val = translatedSublist[y]
              .replaceAllMapped(RegExp('{[^}]+}'), replaceCallback);
          //
          valueInBrackets = '${{val}}';
        }
        buff.write(' ${keys[y]}$valueInBrackets');
      }
      final result = buff.toString();
      buff.clear();
      return result;
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}
