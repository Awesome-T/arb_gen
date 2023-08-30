import 'package:test/test.dart';

import '../../../src/parser/parser_select.dart';
import '../../../src/parser/types_of_content.dart';
import '../../../src/util/errors.dart';

void main() {
  group('ICU Select tests: ', () {
    late SelectPaser select;
    late SelectInnerParser selectInnerParser;
    setUp(() {
      selectInnerParser = const SelectInnerParser();
      select = SelectPaser(selectInnerParser);
    });
    //
    const fakeArb = <String, Object>{
      '@@locale': 'en',
      'appName': 'Demo app',
      'pageLoginUsername': 'Your username',
      '@pageLoginUsername': {},
      'pageLoginPassword': 'Your password',
      '@pageLoginPassword': {},
      'pageHomeTitle': 'Welcome {firstName}',
      '@pageHomeTitle': {
        'description': 'Welcome message on the Home screen',
        'placeholders': {'firstName': {}},
      },
      'pageHomeInboxCount':
          '{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}',
      '@pageHomeInboxCount': {
        'description': 'New messages count on the Home screen',
        'placeholders': {'count': {}},
      },
      'pageHomeBirthday': '{sex, select, male{His birthday} female{Her birthday} other{Their birthday}}',
      '@pageHomeBirthday': {
        'description': 'Birthday message on the Home screen',
        'placeholders': {'sex': {}},
      },
      'commonVehicleType':
          '{vehicleType, select, sedan{Sedan} cabriolet{Solid roof cabriolet} truck{16 wheel truck} other{Other}}',
      '@commonVehicleType': {
        'description': 'Vehicle type',
        'placeholders': {'vehicleType': {}},
      },
      'commonCustomDateFormat': 'Custom date format: {date}',
      '@commonCustomDateFormat': {
        'placeholders': {
          'date': {'type': 'DateTime', 'format': 'EEE, M/d/y', 'isCustomDateFormat': 'true'},
        },
      },
      'productCostInfo': 'Cost: {cost}',
      '@productCostInfo': {
        'placeholders': {
          'cost': {
            'type': 'double',
            'format': 'currency',
            'optionalParameters': {'symbol': '€', 'decimalDigits': 3},
          },
        },
      },
      'postCreatedInfo': 'Created: {date}',
      '@postCreatedInfo': {
        'placeholders': {
          'date': {'type': 'DateTime', 'format': 'MMMd'},
        },
      },
      'roomUnavailableContactOrganiserDialogCount': '{count,plural, =1{an organiser} other{organisers}}',
      '@roomUnavailableContactOrganiserDialogCount': {
        'placeholders': {'count': {}},
      },
      'singleString': 'This is just a normal string.',
      '@singleString': {'context': 'views:Home page', 'description': 'Comment for the single string.'},
      'datePickerMinuteOne': '1 minute',
      'datePickerMinuteOther': r'$minute minutes',
      '@datePickerMinute': {
        'description':
            "Accessibility announcement for the selected minute on a time picker such as '15 minutes' or '15分'",
        'plural': 'minute',
        'placeholders': {
          'minute': {'description': 'the number of minutes', 'example': '15'},
        },
      },
      'contactDetailsPopupEmailCopiedMessage': 'Copied {email} to clipboard',
      '@contactDetailsPopupEmailCopiedMessage': {
        'description': 'Message being displayed in a snackbar upon long-clicking email in contact details popup',
        'placeholders': {
          'email': {'type': 'String', 'example': 'example@gmail.com'},
        },
      },
      'formLabelDone': 'Done',
      '@formLabelDone': {'description': 'Label being displayed below every form field that is filled and valid'},
      'remove_all_done_dialog_body':
          '{count, plural, =1 {Are you sure you want to remove 1 item? This operation cannot be undone.} other {Are you sure you want to remove all {count} items? This operation cannot be undone.}}',
      '@remove_all_done_dialog_body': {
        'placeholders': {
          'count': {'type': 'int', 'format': 'compactLong'},
        },
      },
      'pageHomeBalance': 'Your balance is {amount} on {date}',
      '@pageHomeBalance': {
        'placeholders': {
          'amount': {
            'type': 'double',
            'format': 'currency',
            'example': r'$1000.00',
            'description': 'Account balance',
            'optionalParameters': {'decimalDigits': 2, 'name': 'USD', 'symbol': r'$', 'customPattern': '¤#0.00'},
          },
          'date': {'type': 'DateTime', 'format': 'yMd', 'example': '11/10/2021', 'description': 'Balance date'},
        },
      },
    };

    group('SelectInnerParser', () {
      test(
        '''
hasOtherKeyword()
        should pass''',
        () => expect(
          () => selectInnerParser.hasOtherKeyword(<String, String>{'one': '1', 'two': '2', 'six': '6', 'other': '121'}),
          isNot(isException),
        ),
      );
      test(
        '''
hasOtherKeyword()
        throw IcuParsingException
        because 'other' keyword is not exist''',
        () => expect(
          () => selectInnerParser.hasOtherKeyword(<String, String>{'one': '1', 'two': '2', 'six': '6'}),
          throwsA(isA<IcuParsingException>()),
        ),
      );

      test('''
toVariants()
      shold return string wich look like isu 
      and matches lenght are the same as into keys, translatedSublist arrays ''', () {
        final translatedSublist = <String>['bla bla', 'bla1 bla1', 'bla3 bla3 bla3'];
        final keys = <String>['keys_1', 'keys_2', 'keys_3'];
        final placeholders = <String>['placeholder_1'];
        final result = selectInnerParser.toVariants(translatedSublist, placeholders, keys);
        //todo:  /(\w+)\{([\w*\s*]+)\}/gm
        final match = RegExp(r'(\w+)\{([\w*\s*]+)\}').allMatches(result);
        expect(match.length == translatedSublist.length && match.length == keys.length, isTrue);
      });
    });
    // *
    group('SelectPaser ', () {
      // *
      test('''
fromArb()
      should find all ICU  with "select" keyword 
      and return 2.''', () {
        /// keys wich wu looking for
        final keys = <String>['commonVehicleType', 'pageHomeBirthday'];
        final result = <String, SelectArb>{};
        for (final entry in fakeArb.entries) {
          // select.maatchForStr(entry);
          // if (select.maatchForStr(entry) != null)
          final f = select.fromArb(entry);
          if (f != null) result.addAll(f);
        }
        expect(result.length, keys.length);
        expect(result.keys.every(keys.contains), isTrue);
      });
      // *
      test('''
fromArb()
      should throw `IcuParsingException`
      because keyword `other` not exist.''', () {
        const fakeParsedArb =
            MapEntry<String, String>('pronoun', '{gender, select, male{he} female{she}}');
        // Select the first value which is the `SelectArb` choice source
        // field and remove the entry value at the other key from the Map.
        // fakeParsedArb.values.first.source.remove('other');
        // Act & Assert
        expect(() => select.fromArb(fakeParsedArb), throwsA(isA<IcuParsingException>()));
      });
      // *
      test('''
toSingleStr()
      should pass
      because this value have `separator`''', () {
        final fakeParsedArb = <String, SelectArb>{
          'painters': const SelectArb(
            {
              'first': 'morning',
              'second': 'noon',
              'third': 'afternoon',
              'fourth': 'evening',
              'other': 'night',
            },
            <String>['day_period'],
          ),
        };
        final buff = StringBuffer();
        for (final entry in fakeParsedArb.entries) {
          buff.write(select.toSingleStr(entry));
        }
        expect(buff.toString(), isNotEmpty);
      });
      // *
//       test('''
// separeteTranslation()
//       lenght must be the same as map''', () {
//         final fakeParsedArb = <String, SelectArb>{
//           'globalKey': SelectArb(
//             {
//               'first': 'morning',
//               'second': 'noon',
//               'third': 'afternoon',
//               'fourth': 'evening',
//               'other': 'night',
//             },
//             <String>['period'],
//           ),
//         };
//         final buff = StringBuffer();
//         for (final entry in fakeParsedArb.entries) {
//           buff.write(select.toSingleStr(entry));
//         }
//         final s = select.separeteTranslation(buff.toString())..removeLast();
//         expect(s.length == fakeParsedArb.values.first.source.entries.map((e) => e.value).length, isTrue);
//       });
    });
  });
}