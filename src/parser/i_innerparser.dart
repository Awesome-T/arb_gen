
/// Interface fo
///
abstract interface class IInnerParser {
  const IInnerParser();
  ///
  ///
  String get patern;
  ///
  ({
    Map<String, String> source,
    List<String> placeholders,
  }) parceInnerData(String data);
}
