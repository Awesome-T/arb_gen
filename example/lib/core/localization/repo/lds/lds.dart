import 'package:example/core/localization/repo/lds/localize_ilds.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// The `LDS` class implements the `ILDS` interface using SharedPreferences 
/// for local data storage.
/// 
class LDS implements ILDS {
  /// 
  /// Constructor for `LDS` that takes a `SharedPreferences` instance as a p
  /// arameter.
  /// 
  const LDS(SharedPreferences preferences) : _prefs = preferences;

  final SharedPreferences _prefs;

  /// Creates or updates data with the specified ID in the SharedPreferences.
  ///
  /// Returns `true` if the operation is successful, otherwise `false`.
  @override
  Future<bool?> createOrUpdate(String data, String id) async => await _prefs.setString(id, data);

  /// Reads data from SharedPreferences based on the specified ID.
  ///
  /// Returns the data associated with the ID, or `null` if not found.
  @override
  Future<String?> read(String id) async => _prefs.getString(id);
}
