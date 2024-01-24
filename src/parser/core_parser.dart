// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

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
abstract interface class _ParserArbQ {
  _ParserArbQ(
    Config config,
    Map<String, dynamic> ardData,
    this._select,
    this._plural,
    this._string,
  )   : _arbContent = ardData,
        _config = config {
    validateMap();
  }

  /// Static instances of various parser classes.
  final SelectPaser _select;

  ///
  final PluralParser _plural;

  ///StringParser
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
      // *
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

  /// Checks if the key is not ignoredn
  ///
  /// and doesn't start with '@'.
  bool _entryIssuitable(String a) =>
      !_config.ignored.contains(a) &&
      !a.startsWith(
        '@',
      );

  /// Getter for parsing the ARB content and converting
  ///
  /// it into a parsed result.
  Map<String, DTArb<dynamic>> get fromArb {
    //
    final parsedResult = <String, DTArb<dynamic>>{};
    //
    for (var i = 0; i < _arbContent.entries.toList().length; i++) {
      //
      final revord = _arbContent.entries.toList()[i];
      //
      if (_entryIssuitable(revord.key) && revord.value is String) {
        final data = fronArdProcess(revord);
        parsedResult.addAll(data);
      }
      continue;
    }
    if (parsedResult.isEmpty) {
      throw const ArbDataException(
        'no data to translaqte',
      );
    }
    return parsedResult;
  }

  ///
  /// Converts the parsed result into a single string.
  ///
  String toSingleStr(Map<String, DTArb<dynamic>> parsedData) {
    final buffer = StringBuffer();
    for (var i = 0; i < parsedData.length; i++) {
      buffer.writeln(toSingleStrProcess(parsedData.entries.toList()[i]));
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
          // * result: result

          result.addAll(
            strToMapProcess(
              parsedChank: parsedChank,
              translatedChank: translatedChank,
              arbChank: arbChank,
            ),
          );
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
      final newMap = data.arbContent;
      // *
      for (final element in data.map.entries) {
        newMap[element.key] = element.value;
      }
      return newMap;
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }

  ///
  ///
  ///
  String toSingleStrProcess(MapEntry<String, DTArb<dynamic>> entry);

  ///
  ///
  ///
  Map<String, dynamic> strToMapProcess({
    required DTArb<dynamic> parsedChank,
    required List<String> translatedChank,
    required Map<String, dynamic> arbChank,
  });

  ///
  ///
  ///
  Map<String, DTArb<dynamic>> fronArdProcess(MapEntry<String, dynamic> revord);
}

///
///
///
@reopen
class Pprocessing extends _ParserArbQ {
  Pprocessing(
    super.config,
    super.ardData,
    super.select,
    super.plural,
    super.string,
  );

  @override
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

  @override
  Map<String, dynamic> strToMapProcess({
    required DTArb<dynamic> parsedChank,
    required List<String> translatedChank,
    required Map<String, dynamic> arbChank,
  }) {
    return switch (parsedChank) {
      SelectArb() => _select.toArb(
          parsedChank,
          translatedChank,
          arbChank.keys.first,
        ),
      PuralArb() => _plural.toArb(
          parsedChank,
          translatedChank,
          arbChank.keys.first,
        ),
      StringArb() => _string.toArb(
          parsedChank,
          translatedChank,
          arbChank.keys.first,
        )
    };
  }

  @override
  String toSingleStrProcess(
    MapEntry<String, DTArb<dynamic>> entry,
  ) =>
      switch (entry.value) {
        SelectArb() => _select.toSingleStr(entry.vCast<SelectArb>()),
        PuralArb() => _plural.toSingleStr(entry.vCast<PuralArb>()),
        StringArb() => _string.toSingleStr(entry.vCast<StringArb>())
      };
}
