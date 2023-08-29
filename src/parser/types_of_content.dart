///
/// Represents a base class for ICU (International Components
///  for Unicode) keywords.
///
/// - [SelectArb] for ICU select keyword
/// - [PuralArb] for ICU plural keyword
/// - [StringArb] for simple string
///// [DtArrayStrSource] for an array of strings
sealed class DTArb<T> {
  const DTArb(this.source, this.placeholders);

  /// The source value of type `T`.
  final T source;

  /// List of placeholders in the source.
  final List<String>? placeholders;
}

///
/// Represents an ICU select keyword.
///
base class SelectArb extends DTArb<Map<String, String>> {
  const SelectArb(super.source, super.placeholders);
}

///
/// Represents an ICU plural keyword.
///
base class PuralArb extends DTArb<Map<String, String>> {
  const PuralArb(super.source, super.placeholders);
}

///
/// Represents a simple string.
///
base class StringArb extends DTArb<String> {
  const StringArb(super.source, super.placeholders);
}

///
/// Represents an array of strings.
///
// base class DtArrayStrSource extends DTArb<List<dynamic>> {
//   DtArrayStrSource(super.source, super.placeholders);
// }

///
/// Keywords for ICU
///
enum IcuKeyWord {
  /// Use a "plural" argument to select
  /// sub-messages based on a numeric value,
  /// together with the plural rules for the
  /// specified language.
  plural,

  /// Use a "select" argument to select sub-messages
  /// via a fixed set of keywords.
  select,
}
