/// 
/// The `ILDS` interface defines methods for Local Data Storage operations.
/// 
abstract interface class ILDS {
  /// Creates or updates data with the specified ID in the local storage.
  ///
  /// Returns `true` if the operation is successful, otherwise `false`.
  Future<bool?> createOrUpdate(String data, String id);

  /// Reads data from the local storage based on the specified ID.
  ///
  /// Returns the data associated with the ID, or `null` if not found.
  Future<String?> read(String id);
}
