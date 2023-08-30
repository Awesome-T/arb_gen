import 'package:test/test.dart';

import '../../../src/util/config.dart';

// A Mock Cat class
//class MockConfigt extends Mock implements Config {}

void main() {
  group(
    'Config load testing',
    () {
      setUpAll(() {
        // Register fallback values when using
        // `any` or `captureAny` with custom objects.
        //  registerFallbackValue(MockConfigt());
      });
      late Config configuration;
      final data = {
        'translateTo': ['en', 'fr', 'uk', 'de'],
        'baseLanguage': 'en',
        'preferredLanguage': 'en',
        'ignored': ['appName'],
        'pathToFile': 'arb.gen/content.json',
        'outputFolder': '1localization',
        'translater': null,
        'apiKey': null,
        'outputClass': 'LocalizationClass',
        'allAtOnce': true,
        'arbName': 'localyzation',
      };

      ///
      setUp(() {
        //  configuration = MockConfigt();
        configuration = Config.load(data);
      });

      test(
        '''
load()
should load a Config''',
        () {
          expect(configuration, isA<Config>());
          expect(configuration, isNot(isException));

          // Verify the interaction.
          //  verify(() =>  configuration.chekSettingsAndContent()).called(1);

          // expect(
          //   Config.load(data),
          //   isA<Config>(),
          // );
        },
      );
    },
  );
//   //
//   group('Config Exeption testing', () {
//     test(
//       """
// load()
//         should throw a ConfigArgException
//         because the language code for 'preferredLanguage' is incorrect.""",
//       () => expect(
//         () {
//           return Config.load({
//             'preferredLanguage': 'ErrorCode',
//             'translateTo': ['it', 'pl', 'fr', 'af'],
//             'pathToFile': 'arb.gen/content.json',
//           });
//         },
//         throwsA(isA<Exception>()),
//         // throwsA(
//         //   isException.having(
//         //     (Exception p0) => p0,
//         //     'Exception',
//         //     isA<ConfigArgException>(),
//         //   ),
//         // ),
//       ),
//     );

//     test(
//       '''
// load()
//         should throw a ConfigArgException
//         because the language code for 'baseLanguage' is incorrect.''',
//       () => expect(
//         () => Config.load({
//           'baseLanguage': 'code',
//           'translateTo': ['it', 'pl', 'fr', 'af'],
//           'pathToFile': 'arb.gen/content.json',
//         }),
//         throwsA(isA<Exception>()),
//       ),
//     );
//     test(
//       '''
// factories load()
//         should throw a ConfigArgException
//         because the translater and apiKey are different types''',
//       () => expect(
//         () => Config.load({
//           'translater': null,
//           'apiKey': 'BKjbkjbbkjbkjbkj',
//           'translateTo': ['en', 'fr', 'de'],
//           'pathToFile': 'arb.gen/content.json',
//         }),
//         throwsA(isA<Exception>()),
//       ),
//     );

// //     ///
// //     test(
// //         '''
// // lshould()
// //         should throw a ConfigArgException
// //         because the language code for 'translateTo' is incorrect.''',
// //         () => expect(
// //               () => Config.load(<String, Object?>{
// //                 'translateTo': ['it', 'pl', 'fr', 'ErrorCode'],
// //                 'pathToFile': 'arb.gen/content.json',
// //               }),
// //               throwsA(isA<Exception>()),
// //               //  throwsA(isA<ConfigArgException>())
// //               // throwsA(isA<ConfigArgException>()),
// //               // throwsA(isException
// //               //     .having((p0) => p0, 'error one', isA<ConfigArgException>())
// //               //     .having((p0) => p0, 'Exception', isA<Exception>()))),
// //             ),);

//     // test(
//     //   '''outputClass
//     //   should pass
//     //   because 'outputClass' is correct.
//     //   ''',
//     //   () {
//     //     final _data = {'outputClass': 'className'};
//     //     var field = _data['outputClass'];
//     //     expect(
//     //       () => (field != null) ?tite: throw ConfigArgException('outputClass must be a string') ,
//     //      isA<bool>(),
//     //     );
//     //   },
//     // );

// //
//     test(
//       '''
// outputClass
//     should throw a ConfigArgException
//     because 'outputClass' is wrong type.''',
//       () => expect(
//         () => Config.load(<String, Object?>{
//           'outputClass': ['className'],
//           'translateTo': ['it', 'pl', 'fr'],
//           'pathToFile': 'arb.gen/content.json',
//         }),
//         throwsA(isA<TypeError>()),
//       ),
//     );
//     //
//     test(
//       '''
// outputClass
//       should throw a ConfigArgException
//       because 'outputClass' is wrong name''',
//       () => expect(
//         () => Config.load(<String, Object?>{
//           'outputClass': '1className',
//           'translateTo': ['it', 'pl', 'fr'],
//           'pathToFile': 'arb.gen/content.json',
//         }),
//         throwsA(isA<Exception>()),
//       ),
//     );
//     test(
//       '''
// lshould()
//       should throw a ConfigArgException
//       because 'arbName' field is incorrect.''',
//       () => expect(
//         () => Config.load(<String, Object?>{
//           'translateTo': ['it', 'fr'],
//           'pathToFile': 'arb.gen/content.json',
//           'arbName': '111',
//         }),
//         throwsA(isA<Exception>()),
//       ),
//     );

//     ///
//     test(
//       '''
// lshould()
//       should throw a ConfigArgException
//       because 'arbName' type is not a String''',
//       () => expect(
//         () => Config.load(<String, Object?>{
//           'translateTo': ['it', 'fr'],
//           'pathToFile': 'arb.gen/content.json',
//           'arbName': 111,
//         }),
//         throwsA(isA<TypeError>()),
//       ),
//     );

//     //
//     test(
//       '''
// lshould()
//         should throw a ConfigArgException
//          because 'allAtOnce' type is not a bool type''',
//       () => expect(
//         () => Config.load(<String, Object?>{
//           'translateTo': ['it', 'fr'],
//           'pathToFile': 'arb.gen/content.json',
//           'allAtOnce': 'tite',
//         }),
//         throwsA(isA<TypeError>()),
//         // throwsA(isA<ConfigArgException>()),
//       ),
//     );
//   });
}
