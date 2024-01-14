/// The `LoadLocaleUCParam` class is a base class for 
/// parameters used in the load locale use case.
class LoadLocaleUCParam {
  const LoadLocaleUCParam();
}

/// The `UpdateLocaleUCParam` class is a base class for 
/// parameters used in the update locale use case.
class UpdateLocaleUCParam {
  /// The language code to be updated.
  final String code;

  /// Constructor for `UpdateLocaleUCParam` that takes the 
  /// language code as a parameter.
  const UpdateLocaleUCParam({required this.code});
}
