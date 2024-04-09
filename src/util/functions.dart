// ignore: lines_longer_than_80_chars
// ignore_for_file: avoid_stdout.write, avoid_bool_literals_in_conditional_expressions, unused_local_variable
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

import 'constraints.dart';

///
/// Creates a `l10n.yaml` file based on the provided `Config`.
/// Returns `true` if the file is created successfully,
/// `false` otherwise.
/// `baseLanguage` default language code
Future<void> createL10nyaml(
  String arbName,
  String langCode,
  String? outputClass,
  String nameOfFileLocalization,
  String? preferredLanguage,
) async {
  try {
    final codes = <String>[langCode];
    // *
    if (preferredLanguage != null) codes.add(preferredLanguage);
    const l10n = 'l10n.yaml';
    final e = !codes.every(FlutterSupportedLanguages.keys.toList().contains);
    final path =
        <String>[Directory.current.path, l10n].join(Platform.pathSeparator);
    final file = File(path);
    final isExists = file.existsSync();
    if (isExists) file.deleteSync();

    return await file
        .create(recursive: true)
        .then(
          (file) => file
              .writeAsString(
            _StringsSo.l10nFile(
              arbName,
              langCode,
              outputClass,
              nameOfFileLocalization,
              preferredLanguage,
            ),
          )
              .then((_) {
            stdout.write('File $l10n created');
            return;
          }),
        )
        .onError(
      (error, stackTrace) {
        final msg = '''
File $l10n ERROR $error
''';
        stderr.write(msg);
        throw Exception(msg);
      },
    );
  } catch (e) {
    final msg = '''
Exception l10n.yaml NOT CREATEDm$e
''';
    stdout.write(msg);
    throw Exception(msg);
  }
}

/// Upgrades the `pubspec.yaml` file by adding necessary dependencies
/// related to localization (flutter_localizations, intl) and code generation.
/// Also adds the `generate: true` flag.
Future<void> upgradePubspec() async {
  // *
  final yamlPath = <String>[
    Directory.current.path,
    'pubspec.yaml',
  ].join(Platform.pathSeparator);

  // *
  final pubspecFile = File(yamlPath);
  // *
  final lines = pubspecFile.readAsLinesSync();
  // *
  final origennArray = List<String>.unmodifiable(lines);
  // *
  final hasLocalization = lines.indexWhere(
            (i) => i.contains(RegExp('(flutter_localizations:){1}')),
          ) !=
          -1
      ? true
      : false;
  // *
  final hasIntl =
      lines.indexWhere((i) => i.contains(RegExp('(intl:){1}'))) != -1
          ? true
          : false;
  // *
  final hasGenerate =
      lines.indexWhere((i) => i.contains(RegExp('(generate: true){1}'))) != -1
          ? true
          : false;
// *
  if (!lines.contains('    sdk: flutter')) {
    throw Exception('ERROR: pubspec.yaml has no Flutter SDK dependency');
  }

  for (var i = 0; i < lines.length; i++) {
    if (lines[i] == '' || lines[i].startsWith('#')) continue;

    if (lines[i] == '''  flutter:''') {
      for (var a = i; a < lines.length; a++) {
        if (lines[a] == '''    sdk: flutter''') {
          if (!hasLocalization && !hasIntl) {
            lines.insert(a + 1, _StringsSo.allDependencies);
            stdout.write('''
Added intl and flutter_localizations packages
''');
            break;
          }
          if (!hasIntl) {
            lines.insert(a + 1, _StringsSo.inplPakage);
            stdout.write('''
Added intl package
''');
            break;
          }
          if (!hasLocalization) {
            lines.insert(a + 1, _StringsSo.localizationPack);
            stdout.write('''
Added flutter_localizations package
''');
            break;
          } else {
            continue;
          }
        }
      }
    }

    if (lines[i] == '''flutter:''' && !hasGenerate) {
      lines.insert(i + 1, _StringsSo.geterate);
    } else {
      continue;
    }
  }

  // ignore: inference_failure_on_instance_creation
  final isNotTheSame = !const IterableEquality().equals(origennArray, lines);

  if (isNotTheSame) {
    stdout.write('''
UPDATING pubspec.yaml
''');
    final buf = StringBuffer();
    for (final element in lines) {
      buf.writeln(element);
    }
    File(yamlPath)
      ..createSync()
      ..writeAsStringSync(buf.toString());
  }
  //
  else {
    stdout.write('''
No need to update pubspec.yaml
''');
    return;
  }
}

/// Runs `flutter pub get` command and returns `true`
/// if successful, `false` otherwise.
Future<bool> runFlutterPubGet() async {
  final arguments = <String>['pub', 'get'];
  return Process.run(
    'flutter',
    arguments,
    runInShell: true,
  ).then((ProcessResult result) {
    if (result.exitCode != 0) {
      stderr.write('''
flutter pub get was finished, all files.
exitCode ${result.exitCode}
stderr ${result.stderr}
''');

      throw ProcessException(
        'flutter ',
        arguments,
        '${result.stderr}',
        result.exitCode,
      );
    } else {
      return true;
    }
  });
}

///
/// Moves files from the `.dart_tool/flutter_gen`
///
/// directory to `lib/$outPutFolder` directory.
///
Future<void> moveFolderAndFiles(String outPutFolder) async {
  try {
    final path = <String>[Directory.current.path, 'lib', outPutFolder]
        .join(Platform.pathSeparator);
    final targetDirectory = Directory(path);
    targetDirectory.existsSync() == true
        ? targetDirectory.deleteSync(recursive: true)
        : null;

    final dartToolGen = [Directory.current.path, '.dart_tool', 'flutter_gen']
        .join(Platform.pathSeparator);
    final sourceDirectory = Directory(dartToolGen);

    if (!targetDirectory.existsSync()) {
      targetDirectory.createSync(recursive: true);
    }

    final files = sourceDirectory.listSync();

    for (final file in files) {
      if (file.path.endsWith('.yaml')) continue;
      final newPath = [
        targetDirectory.path,
        file.uri.pathSegments.last,
      ].join(Platform.pathSeparator);
      file.renameSync(newPath);
    }
    await sourceDirectory.delete(recursive: true);
    stdout.write('''
Generated files was moved into 'lib' directory 
''');
  } on PathNotFoundException catch (e) {
    throw PathNotFoundException('$e\n$outPutFolder', const OSError());
  }
}

///
///
void createMapWithLangs(List<String> langs, String lDirName) {
  //
  try {
    final tr = Map<String, Map<String, String>>.fromEntries(
      FlutterSupportedLanguages.entries.where((e) => langs.contains(e.key)),
    );

    final jsonString = jsonEncode(tr);
    final path = <String>[
      Directory.current.path,
      'lib',
      lDirName,
      'langs.g.dart',
    ].join(Platform.pathSeparator);
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync('''
  ///
  const Map<String, Map<String, String>> LANGS = $jsonString;''');
  } on Exception catch (e) {
    throw Exception('$e');
  }
}

///
/// Internal class containing strings used in the functions.
class _StringsSo {
  _StringsSo._();

  static const String allDependencies = '''
  flutter_localizations:
    sdk: flutter
  intl:''';

  static const String inplPakage = '''  intl:''';

  ///
  static const String localizationPack = '''
  flutter_localizations:
    sdk: flutter''';

  ///
  static const String geterate = '''  generate: true''';

  ///
  /// lDirName `localization.dart` file
  static String l10nFile(
    String arbName,
    String langCode,
    String? outputClass,
    String className,
    String? preferredLanguage,
  ) {
    final s = '''
  # The directory where the template and translated arb files are located.The default is lib/l10n.
  arb-dir: lib/l10n
  template-arb-file: ${arbName}_$langCode.arb

  output-class: ${outputClass ?? r'$L'}
  # synthetic_package: false
  # Specifies whether the localizations class getter is nullable.
  nullable-getter: false
  # When specified, the dart format command is run after generating the localization files.
  format: true
  # untranslated-messages-file: untranslated.json

  # Whether to use deferred loading for different locale 
  # localization classes, used on Flutter Web only
  use-deferred-loading: false
  # output-localization-file: l10n.dart

  # Filename of your result Dart file
  output-localization-file: $className.g.dart''';
    final b = '''\n  preferred-supported-locales:\n    - $preferredLanguage''';
    if (preferredLanguage != null) {
      return s + b;
    }
    return s;
  }
}

///
/// `.gitignore`
Future<void> unpateGitIgnore(String arbDir, String arbName) async {
  final dir = '${Directory.current.path}/.gitignore';
  final gitignoreFile = File(dir);
  final isExists = gitignoreFile.existsSync();
  if (isExists) {
    //
    final lines = gitignoreFile.readAsLinesSync();
// "arbDir": "lib/l10n",
// "arbName": "localization",
    final ignored = '''
$arbDir/
lib/$arbName/''';

    final d = lines.indexWhere(
              (i) => i.contains(
                RegExp(
                  r'$ignored',
                  // '($ignored){1}',
                  multiLine: true,
                ),
              ),
            ) !=
            -1
        ? true
        : false;

    if (!d) {
      lines.insert(lines.length, ignored);
      final buf = StringBuffer();
      for (final element in lines) {
        buf.writeln(element);
      }
      final data = buf.toString();
      buf.clear();
      File(dir)
        ..createSync()
        ..writeAsStringSync(data);
      stdout.writeln('''
.gitignore  updated
''');
    }
  }
}
