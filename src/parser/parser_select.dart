// ignore_for_file: directives_ordering, lines_longer_than_80_chars

import 'i_innerparser.dart';
import 'i_parser.dart';
import 'types_of_content.dart';
import '../util/errors.dart';

// sealed class WifiPinCodeConnectionErrors implements Enum {
//   // static const wifiNotFound = WifiBaseErrors.wifiNotFound;
//   // static const permisionMissing= WifiBaseErrors.permisionMissing;
//   // static const wifiTurnedOff = WifiBaseErrors.wifiTurnedOff;
//   // static const wrongPin = _WifiPinCodeConnectionErrors.wrongPin;
//   // static const pinTooShort = _WifiPinCodeConnectionErrors.pinTooShort;
//   static const List<WifiPinCodeConnectionErrors> values = [
//  //   wifiNotFound, permisionMissing, wifiTurnedOff, wrongPin, pinTooShort,
//   ];
// }
// void main(List<String> args) {
//   WifiPinCodeConnectionErrors.values.map((e) => e.name);
// }

///
///
const String _R_SELECT = r'{\s*(\w+)\s*,\s*select\s*,((?:\s*\w+\s*{[^}]+}\s*)+)(?:\s*other\s*{([^}]+)\s*})?\s*}';

/**
 * 
    "pronoun": "{gender, select, male{he} female{she} other{they}}",
    "@pronoun": {
      "description": "A gendered message",
      "placeholders": {
        "gender": {
          "type": "String"
        }
      }
    }
 */
///
/// Base class `StrSelectPaser` extending `CoreParser<String>`.
///

base class SelectPaser extends IParset<SelectArb> {
  SelectPaser(
    SelectInnerParser selectInnerParser, [
    String patern = _R_SELECT,
  ])  : _selectInnerParser = selectInnerParser,
        super(RegExp(patern));
  final SelectInnerParser _selectInnerParser;

  ///

  @override
  Map<String, dynamic> toArb(
    SelectArb parsedChank,
    List<String> translatedChank,
    String key,
  ) {
    assert(translatedChank.isNotEmpty, 'no translations');
    try {
      // *
      final counVariants = parsedChank.source.entries.length;
      // *
      final translatedSublist = translatedChank.getRange(0, counVariants).toList();
      // *
      final keys = parsedChank.source.entries.map((e) => e.key).toList().cast<String>();
      // *
      final toVariants = _selectInnerParser.toVariants(translatedSublist, parsedChank.placeholders ?? [], keys);
      // *
      final translatedArbKey = '{${parsedChank.placeholders?.first}, ${IcuKeyWord.select.name},$toVariants}';
      // *

//       print('''
// $runtimeType
// $keys
// $counVariants
// placeholders
// $translatedSublist
// ''');
//           print('''
// $runtimeType
// translatedChank ${translatedChank.length}
// ''');
      final result = <String, String>{key: translatedArbKey};
      translatedChank.length == (parsedChank.source.entries.length)
          ? translatedChank.clear()
          : translatedChank.removeRange(0, parsedChank.source.entries.length);
      return result;
    } on IcuParsingException catch (e) {
      // print('Error $e');
      throw IcuParsingException('$e');
    }
  }

  @override
  String toSingleStr(MapEntry<String, SelectArb> entry) {
    final buff = StringBuffer();
    // hasOtherKeyword(entry);
    // buff.write('$str$separator');
    for (final str in entry.value.source.values) {
      buff.writeln(str);
    }

    final result = buff.toString();
    buff.clear();
    return result;
  }

  @override
  Map<String, SelectArb>? fromArb(MapEntry<String, dynamic> entry) {
    try {
      final match = maatchForStr(entry);
      if (match != null) {
        // *  final String firstPlaceholder = match.group(1)!;
        // *   List<String> placeholders = [firstPlaceholder]
        final placeholders = <String>[match.group(1)!];
        // * "male{he} female{she} other{they}}"
        final icuStr = match.group(2)!;
        //
        final values = RegExp('{(.*?)}').allMatches(icuStr).map((match) => match.group(1)!);
        //
        final finaliables =
            icuStr.replaceAll(RegExp('{.*?}', multiLine: true), '').split(' ').where((e) => e.isNotEmpty);
        //
        final data = Map<String, String>.fromIterables(finaliables, values);
        //
        _selectInnerParser.hasOtherKeyword(data);
        //hasOtherKeyword(_data);
        final result = <String, SelectArb>{
          entry.key: SelectArb(data, placeholders),
        };
        return result;
      }
    } on IcuParsingException catch (e) {
      //   print('Exception $e\n$tr');
      throw IcuParsingException('$e');
    } on FormatException catch (e) {
      throw FormatException('$e');
    }
    return null;
  }
}

///
///
///
class SelectInnerParser implements IInnerParser {
  const SelectInnerParser();

  ///
  @override
  ({List<String> placeholders, Map<String, String> source}) parceInnerData(String data) {
    try {
      final match = RegExp(patern).firstMatch(data);
      // final String firstPlaceholder = match!.group(1)!;
      //
      final placeholders = <String>[match!.group(1)!];
      //
      final keyValuePairs = match.group(2)!;
      //
      final values = RegExp('{(.*?)}').allMatches(keyValuePairs).map((match) => match.group(1)!);
      //
      final finaliables =
          keyValuePairs.replaceAll(RegExp('{.*?}', multiLine: true), '').split(' ').where((e) => e.isNotEmpty);
      //
      final source = Map<String, String>.fromIterables(finaliables, values);
      final result = (placeholders: placeholders, source: source);
      return result;
    } on FormatException catch (e) {
      const msg = '''FormatException: does not follow valid regular expression syntax.''';
      print(msg);
      throw FormatException('$e');
    }
    // final List<String> values = RegExp(r'{(.*?)}')
    //     .allMatches(keyValuePairs)
    //     .map(
    //       (match) => match.group(1)!,
    //     )
    //     .toList();
    // final List<String> finaliables =
    //     keyValuePairs.replaceAll(RegExp(r'{.*?}', multiLine: true), '').split(' ').where((e) => e.isNotEmpty).toList();
  }

  ///
  void hasOtherKeyword(Map<String, String> map) {
    assert(map.isNotEmpty, 'map.isNotEmpty');
    const otherKyeWord = 'other';
    final hasOtherKeyword = map.keys.contains(otherKyeWord) ||
        map.keys.contains(otherKyeWord.toLowerCase()) ||
        map.keys.contains(otherKyeWord.toUpperCase());
    if (!hasOtherKeyword) {
      final msg =
          '''Exception: key ${map.keys.toList()} - argument option must have `${otherKyeWord.toLowerCase()}` keyword clause\b$map''';
      print(msg);
      throw IcuParsingException(msg);
    }
  }

  ///
  /// `toArb()`
  ///
  String toVariants(List<String> translatedSublist, List<String> placeholders, List<String> keys) {
    //assert(keys.length == translatedSublist.length, 'keys.length != translatedSublist.length');
    try {
      final buff = StringBuffer();
      // create Strings wich look like this patern : `variant{Value }`
      for (var y = 0; y < translatedSublist.length; y++) {
        buff.write(' ${keys[y]}{${translatedSublist[y]}}');
      }
      // *  `{placehoilder, select, variant{Value} other{Other}}`
      final y = buff.toString();
      buff.clear();
      return y;
    } on Exception catch (e) {
      throw Exception('$e');
    } on AssertionError catch (e) {
      throw AssertionError(e);
    }
  }

  @override
  String get patern => _R_SELECT;
}
