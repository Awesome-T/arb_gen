// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'types_of_content.dart';

// Represents a base class for ICU (International
// Components for Unicode) keywords.
// - [SelectArb] for ICU select keyword
// - [PuralArb] for ICU plural keyword
// - [StringArb] for simple string
abstract class _IParset<T extends DTArb<dynamic>> {
  const _IParset(this.mainRegexp);

  ///
  /// Regular expression to be used by subclasses.
  ///
  final RegExp mainRegexp;

  ///
  /// Checks if the type of value to be processed by the parser is valid.
  ///
  bool confirmVal(MapEntry<String, T> entry) {
    return (entry.value is String) || (entry.value is List);
  }

  /// Regular expression to be used by subclasses.
  /// Matches the first occurrence of the regular
  /// expression for a string value in the given map.
  /// must call incide `fromArb()`
  RegExpMatch? maatchForStr(MapEntry<dynamic, dynamic> map) {
    if (map.value is String) return mainRegexp.firstMatch(map.value as String);
    return null;
  }

  ///
  /// Separator string used to concatenate multiple translations.
  ///
  // String get separator => SEPARATOR;

  ///
  /// Separates a concatenated translation string into a list of
  /// individual translations.
  List<String> separeteTranslation(String data) {
    final regex = RegExp(r'(.*\n)|(.*)');
    final matches = regex.allMatches(data).toList();
    final result = <String>[];
    for (var i = 0; i < matches.length; i++) {
      result.add((matches[i].group(0)!).trim());
    }
    return result;
  }
}

/// Abstract interface class `IParset`.
/// Defines the common structure and methods for parsing and
/// converting data in ARB format.
abstract class IParset<T extends DTArb<dynamic>> extends _IParset {
  const IParset(super.mainRegexp);

  ///
  /// Parses data from ARB format.
  ///
  // Map<String, T>? fromArb(Map<String, dynamic> map);
  Map<String, T>? fromArb(MapEntry<String, dynamic> map);

  ///
  /// Converts the parsed data to a single string.
  /// key - key in .arb
  /// `His birthday ||| Her birthday ||| Their birthday ||| `
  String toSingleStr(MapEntry<String, T> entry);

  ///
  /// Converts data to ARB format.
  /// Map<String, dynamic> _arbChank,
  Map<String, dynamic> toArb(
    T parsedChank,
    List<String> translatedChank,
    String key,
  );
}
