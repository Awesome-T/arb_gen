import 'dart:io';

import 'package:test/test.dart';

import '../../src/util/pls_updater.dart';
void main() {
  group('IosUpdater testing ', () {
   // late IosUpdater iosUpdater;
   // setUp(() => iosUpdater = const IosUpdater());
    test(
      '''
hasIosPlatform()
should throw a PathNotFoundException
because directory is incorrect.
''',
      () => expect(
        () => IosUpdater.updPls('example_', <String>['en', 'fr', 'de']),
        throwsA(isA<PathNotFoundException>()),
      ),
    );
    test(
      '''
hasIosPlatform()
      is not error
''',
      () => expect(
        () => IosUpdater.updPls('example', <String>['en', 'fr', 'de']),
        isNot(isException),
      ),
    );
  });
}
