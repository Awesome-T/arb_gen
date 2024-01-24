import '../util/config.dart';
import '../util/errors.dart';
import 'map_casting.dart';
import 'parser_plural.dart';
import 'parser_select.dart';
import 'parser_str.dart';
import 'types_of_content.dart';

/// Abstract interface class `ParserArb`.
/// Handles the parsing and conversion of ARB content to a parsed result.
/// - .arb - just Map
/// - [Config]
class ParserArb {
  ParserArb(
    Config config,
    Map<String, dynamic> ardData, {
    SelectPaser? select,
    PluralParser? plural,
    SimpleStrParser? string,
    PluralInnerParser? pluralInnerParser,
    SelectInnerParser? selectInnerParser,
  })  : _arbContent = ardData,
        _config = config,
        _plural = plural ??
            PluralParser(
              pluralInnerParser ?? const PluralInnerParser(),
            ),
        _select = select ??
            SelectPaser(
              selectInnerParser ?? const SelectInnerParser(),
            ),
        _string = string ?? SimpleStrParser() {
    validateMap();
  }

  ///
  final SelectPaser _select;

  ///
  final PluralParser _plural;

  ///
  final SimpleStrParser _string;

  ///
  final Map<String, dynamic> _arbContent;

  ///
  final Config _config;

  /// Validates the ARB entry to ensure it meets the required format.
  /// * `flutter gen-l10n` throws if any key are contain `.`
  /// * value for internalization must be a  String type
  void validateMap() {
    for (final element in _arbContent.entries) {
      //
      if (element.key.contains('.')) {
        throw ArbDataException(
          'ERROR: key is not supported${element.key} contain "." ',
        );
      }
      //
      if (!element.key.startsWith('@') && element.value is! String) {
        throw ArbDataException(
          // ignore: avoid_dynamic_calls
          'ERROR: value at key ${element.key}  is ${element.value.runtimeType} - not supported',
        );
      }
    }
  }

  ///
  /// Checks if the key is not ignoredn  and doesn't start with '@'.
  ///
  bool _entryIssuitable(String a) {
    return !_config.ignored.contains(a) && !a.startsWith('@');
  }

  ///
  /// Getter for parsing the ARB content and converting
  /// it into a parsed result.
  Map<String, DTArb<dynamic>> get fromArb {
    //
    final parsedResult = <String, DTArb<dynamic>>{};
    //
    for (var i = 0; i < _arbContent.entries.toList().length; i++) {
      //
      final revord = _arbContent.entries.toList()[i];
      //
      //
      if (_entryIssuitable(revord.key) && revord.value is String) {
        parsedResult.addAll(fronArdProcess(revord));
      }
      continue;
    }
    if (parsedResult.isEmpty) {
      throw const ArbDataException('no data to translaqte');
    }
    return parsedResult;
  }

  ///
  ///
  ///
  Map<String, DTArb<dynamic>> fronArdProcess(
    MapEntry<String, dynamic> revord,
  ) {
    //
    if (_select.maatchForStr(revord) != null) {
      return _select.fromArb(revord)!;
    }
    //
    else if (_plural.maatchForStr(revord) != null) {
      return _plural.fromArb(revord)!;
    }
    //
    else {
      return _string.fromArb(revord)!;
    }
  }

  ///
  /// Converts the parsed result into a single string.
  ///
  String toSingleStr(Map<String, DTArb<dynamic>> parsedData) {
    final buffer = StringBuffer();
    for (var i = 0; i < parsedData.length; i++) {
      final entry = parsedData.entries.toList()[i];
      switch (entry.value) {
        case SelectArb():
          final data = _select.toSingleStr(entry.vCast<SelectArb>());
          buffer.writeln(data.trim());
        case PuralArb():
          final data = _plural.toSingleStr(entry.vCast<PuralArb>());

          buffer.writeln(data.trim());
        case StringArb():
          final data = _string.toSingleStr(entry.vCast<StringArb>());
          buffer.writeln(data.trim());
        // case DtArrayStrSource():
        //   break;
      }
    }
    final result = buffer.toString();
    buffer.clear();
    return result;
  }

  ///
  /// Converts the translated string and language into a entry.
  ///
  Map<String, dynamic> strToMap(
    Map<String, DTArb<dynamic>> parsedData,
    String toTranslate,
  ) {
    try {
      final translatedChank = _select.separeteTranslation(toTranslate);
      assert(translatedChank.isNotEmpty, 'translatedChank is Empty');
      late final result = <String, dynamic>{};
      for (var x = 0; x < _arbContent.entries.length; x++) {
        // *
        final key = _arbContent.entries.toList()[x].key;
        // *
        final val = _arbContent.entries.toList()[x].value;
        // *
        final arbChank = Map<String, dynamic>.unmodifiable({key: val});
        if (_entryIssuitable(arbChank.keys.first)) {
          // *
          final parsedChank = parsedData[arbChank.keys.first];
          if (parsedChank == null) continue;
          switch (parsedChank) {
            case SelectArb():
              final map = _select.toArb(
                parsedChank,
                translatedChank,
                arbChank.keys.first,
              );
              result.addAll(map);
            case PuralArb():
              final map = _plural.toArb(
                parsedChank,
                translatedChank,
                arbChank.keys.first,
              );
              result.addAll(map);
            case StringArb():
              final map = _string.toArb(
                parsedChank,
                translatedChank,
                arbChank.keys.first,
              );
              result.addAll(map);
            // case DtArrayStrSource():
            //   break;
          }
        }
      }
      return result;
    } on Exception catch (e, tr) {
      throw Exception('$e\n$tr');
    }
  }

  ///
  /// Updates the original entry with the translated entry.
  ///
  Map<String, dynamic> updeteMap(
    ({
      Map<String, dynamic> arbContent,
      Map<String, dynamic> map,
    }) data,
  ) {
    try {
      // *
      final newMap = Map<String, dynamic>.from(data.arbContent);
      // *
      for (final element in data.map.entries) {
        newMap[element.key] = element.value;
      }
      return newMap;
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}
