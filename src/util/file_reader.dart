import 'dart:convert';
import 'dart:io';
///
///
///
abstract interface class IFileReader {
  ///
  Future<void> createArb(
    String outputFolder,
    String langCode,
    String arbName,
    Map<dynamic, dynamic> contents,
  );

  ///
  Map<String, dynamic> loadMapFromFile(String path);
}

///
///
class FileReader  implements IFileReader{
  const FileReader();

  ///
  ///
  /// create translation .arb
  ///
  ///
   @override
  Future<void> createArb(
    String outputFolder,
    String langCode,
    String arbName,
    Map<dynamic, dynamic> contents,
  ) async =>
      File('$outputFolder/${arbName}_$langCode.arb')
          .create(recursive: true)
          .then(
            (File value) => value.writeAsString(jsonEncode(contents)).then((File file) {
              print('file created ${file.path}');
              return;
            }).onError<FileSystemException>((error, stackTrace) => throw error),
          )
          .onError<PathExistsException>((error, stackTrace) => throw error);

  /// Interface which returns content file for builder
  /// and configuration for this
  /// part `arb.gen/config.json`
  /// [String path = 'arb.gen/config.json']
   @override
  Map<String, dynamic> loadMapFromFile(String path) {
    try {
      final file = File(path);
      final strFile = file.readAsStringSync();
      //
      final dynamic data = jsonDecode(strFile);
      if (data is! Map) {
        throw FormatException(
          'ERROR ${data.runtimeType} content type of this file must be a map',
          data,
        );
      }
      return jsonDecode(strFile) as Map<String, dynamic>;
    } on PathExistsException catch (e) {
      throw PathExistsException(path, const OSError(), '$e');
    } on PathAccessException catch (e) {
      throw PathAccessException(path, const OSError(), '$e');
    } on PathNotFoundException catch (e) {
      throw PathNotFoundException(path, const OSError(), '$e');
    } on FileSystemException catch (e) {
      throw FileSystemException('$e');
    }
  }
}
