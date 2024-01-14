import 'dart:io';

/// Typically, iOS applications define key application metadata, 
/// including supported locales, in an Info.plist file that is built 
/// into the application bundle. To configure the locales supported by
///  your app, use the following instructions:
/// Open your project’s ios/Runner.xcworkspace Xcode file.
/// In the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder. Select the Information Property List item. 
/// Then select Add Item from the Editor menu, and select Localizations
/// from the pop-up menu.
/// Select and expand the newly-created Localizations item. For each
/// locale your application supports, add a new item and select the
/// locale you wish to add from the pop-up menu in the Value field. This
/// list should be consistent with the languages listed in the supportedLocales
/// parameter.
/// Once all supported locales have been added, save the file.
abstract final class IosUpdater {
  const IosUpdater();

  /// Updates the string in Info.plist with supported locales for iOS.
  /// [langs] - List of language codes for locales.
  static String localeIos(List<String> langs) {
    final buff = StringBuffer();
    for (final i in langs) {
      buff.writeln('    <string>$i</string>');
    }
    final str = buff.toString();
    buff.clear();
    return '''
<key>CFBundleLocalizations</key>
<array>
$str
</array>''';
  }

  /// Checks for the existence of ios and macos folders
  /// and updates Info.plist in each of them.
  /// [languages] - List of language codes.
  static void updPls(String rootPath, List<String> languages) {
    // [rootPath] - Relative path to the project.
    if (!Directory(rootPath).existsSync()) {
      throw PathNotFoundException(
        rootPath,
        OSError('Directory $rootPath not found'),
      );
    }
    final pathSeparator = Platform.pathSeparator;
    final plsFilePath = '${pathSeparator}Runner${pathSeparator}Info.plist';
    final path = '$rootPath$pathSeparator';
    final iosDir = Directory('${path}ios');
    final macosDir = Directory('${path}macos');

    // Check if ios and macos directories exist
    final isExist = (
      hasIos: iosDir.existsSync(),
      hasMacos: macosDir.existsSync(),
    );
    
    if (isExist.hasIos) _updPls(iosDir, plsFilePath, languages);
    if (isExist.hasMacos) _updPls(macosDir, plsFilePath, languages);
    return;
  }

  /// Updates Info.plist in the specified directory.
  /// [iosDir] - ios or macos directory.
  /// [plsFilePath] - Path to Info.plist.
  /// [languages] - List of language codes.
  static void _updPls(
    Directory iosDir,
    String plsFilePath,
    List<String> languages,
  ) {
    final file = File('${iosDir.path}$plsFilePath');
    final lines = file.readAsLinesSync();
    final buff = StringBuffer();

    // Find the index of 'CFBundleLocalizations' in Info.plist
    final localizationsIndx = lines.indexWhere((String i) => i.contains(RegExp('<key>CFBundleLocalizations</key>')));
    final hasLocalizations = localizationsIndx != -1;

    if (hasLocalizations) {
      // If 'CFBundleLocalizations' exists, update the existing section
      final endIndx = localizationsIndx + lines.sublist(localizationsIndx).indexWhere((i) => i.trim() == '</array>');
      for (var i = 0; i < languages.length; i++) {
        if (i == 0) buff.writeln('''    <array>''');
        buff.writeln('''        <string>${languages[i]}</string>''');
        if (i == languages.length - 1) buff.write('''    </array>''');
      }
      final source = buff.toString();
      buff.clear();
      lines
        ..removeRange(localizationsIndx + 1, endIndx + 1)
        ..insert(localizationsIndx + 1, source);
    } else {
      // If 'CFBundleLocalizations' does not exist, add a new section
      for (var i = 0; i < languages.length; i++) {
        if (i == 0) {
          buff.writeln('''
    <key>CFBundleLocalizations</key>
	<array>''');
        }
        buff.writeln('''        <string>${languages[i]}</string>''');
        if (i == languages.length - 1) buff.write('''    </array>''');
      }
      final source = buff.toString();
      buff.clear();
      final dictIndx = lines.indexWhere((String e) => e.trim() == '<dict>');
      lines.insert(dictIndx + 1, source);
    }

    // Write the updated lines back to Info.plist
    try {
      for (final line in lines) {
        buff.writeln(line);
      }
      File(file.path)
        ..createSync()
        ..writeAsStringSync(buff.toString());
      buff.clear();
      stdout.write('''File ${file.path} was updated successfully''');
    } on FileSystemException catch (e) {
      throw FileSystemException('$e');
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}
