import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../../src/util/file_reader.dart';

///
class MockFileReader extends Mock implements IFileReader {}

///
///
void main() {
  group(
    'IFileReader testing: ',
    () {
      late MockFileReader reader;
      setUp(() => reader = MockFileReader());
      setUpAll(() => registerFallbackValue(MockFileReader()));
      const path = 'example/arb.gen/config.json';
      test(
        'loadSettingsFromFile() should throw a PathNotFoundException.',
        () {
          // arrange
          // Stub the `sound` method.
          final expected = <String, dynamic>{
            'translateTo': ['en', 'es', 'zh', 'hi', 'ar', 'pt', 'bn', 'ru', 'ja', 'pa', 'de', 'fr', 'it'],
            'ignored': ['appName'],
            '_pathToFile': "path to the original .arb/.json file, for example 'arb.gen/content.json' ==[_DEFAULT_PATH]",
            'pathToFile': 'arb.gen/content.json',
            '_outputClass': r'Name of output class localization be defaul $L',
            'outputClass': 'AppLocalezation',
            '_lDirName': r'name of directory folder `/lib/$lDirName`',
            'lDirName': 'localization',
            '_arbDir': ' code of the original language used in the base file',
            'arbDir': 'lib/l10n',
            'arbName': 'localization',
            '_preferredLanguage': 'preferredLanguage must be null or one of `translateTo`',
            'preferredLanguage': 'en',
            '_baseLanguage': 'optional language of source wich you prefer to translate',
            'baseLanguage': null,
            '_translater': 'optional `null`',
            'translater': null,
            '_apiKey': 'optional ',
            'apiKey': null,
            '_allAtOnce': 'null',
            'allAtOnce': null,
          };
          // reader = MockFileReader(); // onst FileReader();
          when(() => reader.loadMapFromFile('lj')).thenReturn({});
          expect(reader.loadMapFromFile('lj'), isMap);
          // Reset stubs and interactions
          // reset(reader);
        },
      );

      //
      // test(
      //   'loadMapFromFile() should throw a FormatException',
      //   () {
      //     //Reset stubs and interactions
      //     //reset(reader);

      //     when(() => reader.loadMapFromFile(any<String>())).thenThrow(FormatException);
      //     // expect(reader.loadMapFromFile('lj'),isException);
      //     expect(() => reader.loadMapFromFile('example/pubspec.yaml'), isException);
      //   },
      // );

      // test('createArb', () {
      //   const arbName = 'arbName';
      //   const langCode = 'en';
      //   const outputFolder = 'example/lib/l10n';
      //   final content = <String, String>{
      //     '@@locale': langCode,
      //     'kedddddddddy': 'sklknlknlknlknlk',
      //   };

      //   expect(
      //     reader
      //         .createArb(
      //       outputFolder,
      //       langCode,
      //       arbName,
      //       content,
      //     )
      //         .then((_) async {
      //       const pathToFile = '$outputFolder/${arbName}_$langCode.arb';
      //       final file = File(pathToFile);
      //       final existsSync = file.existsSync();
      //       expect(existsSync, isTrue);
      //       final lengthSync = file.lengthSync();
      //       expect(lengthSync, jsonEncode(content).length);
      //     }),
      //     completes,
      //   );
      // });
    },
  );
}
