import 'package:test/test.dart';

import '../../../src/parser/parser_str.dart';
import '../../../src/parser/types_of_content.dart';

void main() {
  group('ICU SimpleStrParser test:', () {
    late SimpleStrParser sRow;
    // *
    setUp(() => sRow = SimpleStrParser());

    // *
    const fakeArb = <String, Object>{
      '@@locale': 'en',
      'appName': 'Demo app',
      //
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

    test('''
fromArb()
      should find all ICU Selects and 
      return 2.''', () {
      /// keys wich wu looking for
      final keys = <String>[
        'appName',
        'pageLoginUsername',
        'pageLoginUsername',
        'pageLoginPassword',
        'pageHomeTitle',
      ];
      final result = <String, StringArb>{};
      for (final entry in fakeArb.entries) {
        if (sRow.maatchForStr(entry) != null) result.addAll(sRow.fromArb(entry)!);
      }
      expect(result.keys.every(keys.contains), isFalse);
    });
    test(
      '''
toSingleStr() 
        should throw an exception 
        because keyword `other` not exist.''',
      () => expect(
        sRow.toSingleStr(
          {
            'painters': const StringArb('kjbkjb kjbkjbk jbkj jbkjbkj', <String>['day_period']),
          }.entries.first,
        ),
        isA<String>(),
      ),
    );

//     test(
//       '''
// toSingleStr() 
//         return lingle string
//         should pass.''',
//       () => expect(
//         sRow.toSingleStr(
//           {
//             'painters': StringArb('', <String>['day_period']),
//           }.entries.first,
//         ),
//         isNot(isEmpty),
//       ),
//     );

    ///
    test('''
fromArb()
      should find all ICU Select messages''', () {
      final result = <String, StringArb>{};
      for (final entry in fakeArb.entries) {
        if (sRow.maatchForStr(entry) != null) result.addAll(sRow.fromArb(entry)!);
      }
      expect(result.length, 11);
    });
    //
    test('l', () {
      const parsedChank = StringArb('knkjnkjb kjbkjb', <String>['period']);
      const globalKey = 'globalKey';
      final fakeParsedArb = <String, StringArb>{globalKey: parsedChank};
      final buff = StringBuffer();
      for (final entry in fakeParsedArb.entries) {
        buff.write(sRow.toSingleStr(entry));
      }
      //   final List<String> _translatedChank = _buff.toString().split(_sRow.separator);
      //   final Map<String, dynamic> map = _sRow.toArb(parsedChank, _translatedChank, _globalKey);
    });
  });
}
