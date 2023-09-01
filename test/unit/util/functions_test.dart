// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../src/util/functions.dart';

//class FakeCat extends Mock implements Cat {
class FakeFile extends Fake implements File {
  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) async {
    return FakeFile();
  }
}


// https://github.com/dart-lang/test/tree/master/pkgs/test#writing-tests
void main() {
  late List<String> langs;

  group('testing glob functions', () {
    setUp(() {
      langs = ['fr', 'en', 'de', 'ar', 'pl', 'ru'];
    });
    test('createL10nyaml()', () {
      const arbName = 'arbName';
      const langCode = 'fr';
      const outputClass = 'outputClass';
      const nameOfFileLocalization = 'dfs';
      const defaultlanf = 'az';

      expect(
        createL10nyaml(
          arbName,
          langCode,
          outputClass,
          nameOfFileLocalization,
          defaultlanf,
        ).then(
          (_) async {
            final file = File('${Directory.current.path}/l10n.yaml');
            expect(file.existsSync(), isTrue);
            expect(file.lengthSync(), isNonZero);
          },
        ),
        completes,
      );
    });

    test(
      '''Selecting langs''',
      () {
        final str = createMapWithLangs(langs);
        final dynamic map = jsonDecode(str);
        final sTheSame = const ListEquality().equals(
          (map as Map).keys.toList(),
          langs,
        );
        expect(map, isA<Map<dynamic, dynamic>>());
        expect(sTheSame, isTrue);
      },
    );
  });
  // test('description', () {
  //       //       Create a new fake Cat at runtime.
  // var f =  MockFile();
  // f.createSync();
  //      contains();
  // //  stdout.write(languageMap.keys.toList().map(jsonEncode).toList());
  // });
  test('example', () {

    // Stub a method before interacting with the mock.
    //  when(() => f.createSync()).thenReturn('purr');

    // when(
    //   () => cat.likes('fish', isHungry: any(named: 'isHungry')),
    // ).thenReturn(true);

    // Interact with the mock.
    // expect(cat.sound(), 'purr');

    // Verify the interaction.
    //verify(() => cat.sound()).called(1);

    // Stub a method with parameters
    // when(
    //   () => cat.likes('fish', isHungry: any(named: 'isHungry')),
    // ).thenReturn(true);
    // expect(cat.likes('fish', isHungry: true), isTrue);

    // // Verify the interaction.
    // verify(() => cat.likes('fish', isHungry: true)).called(1);

    // // Interact with the mock.
    // cat
    //   ..eat(Chicken())
    //   ..eat(Tuna());

    // // Verify the interaction with specific type arguments.
    // verify(() => cat.eat<Chicken>(any())).called(1);
    // verify(() => cat.eat<Tuna>(any())).called(1);
    // verifyNever(() => cat.eat<Food>(any()));
  });
}
