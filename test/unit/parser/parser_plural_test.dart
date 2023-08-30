// ignore_for_file: inference_failure_on_collection_literal

import 'package:collection/collection.dart';
import 'package:test/test.dart';

import '../../../src/parser/parser_plural.dart';
import '../../../src/parser/types_of_content.dart';
import '../../../src/util/errors.dart';
void main() {
  group('ICU Plural tests: ', () {
    late PluralParser plural;
    late PluralInnerParser pluralInnerParser;

    setUp(() {
      pluralInnerParser = const PluralInnerParser();
      plural = PluralParser(pluralInnerParser);
    });

    group('PluralInnerParser test ', () {
      //  *
      test('''
parceInnerData()
      should pass
      because same values and lenght into source.keys as keysArray''', () {
        //
        const variantStr = '''
zero{You have no new messages} 
one{You have 1 new message} 
two{You have 2 new messages} 
few{You have {count} new messages} 
many{You have {count} new messages} 
other{You have {count} new messages}''';
        const keysArray = <String>['zero', 'one', 'two', 'few', 'many', 'other'];
        //  "zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}";
        expect(
          const DeepCollectionEquality()
              .equals(keysArray, pluralInnerParser.parceInnerData(variantStr).source.keys.toList()),
          isTrue,
        );
      });
      //  *
      test('''
parceInnerData()
      should throw error 
      because other keyword is not exist''', () {
        const variantStr = '''
zero{You have no new messages} 
one{You have 1 new message} 
two{You have 2 new messages} 
few{You have {count} new messages} 
many{You have {count} new messages} ''';
        //  "zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}";
        expect(
          () => pluralInnerParser.parceInnerData(variantStr),
          throwsA(isA<IcuParsingException>()),
        );
      });
    });

    group('''ICU PluralParser test: ''', () {
      //  *
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

        // Home page
        'pageHomeWeather':
            "{weather, select, sunny{It's a sunny day!} rainy{Don't forget your umbrella!} snowy{Winter wonderland} cloudy{Partly cloudy today} other{Weather unknown}}",
        '@pageHomeWeather': {
          'description': 'Weather status message on the Home screen',
          'placeholders': {
            'weather': {'description': 'Current weather conditions'},
          },
        },

        // Notifications
        'notificationPriority':
            '{priority, select, low{Low priority} medium{Medium priority} high{High priority} emergency{Emergency alert} other{General notification}}',
        '@notificationPriority': {
          'description': 'Notification priority level',
          'placeholders': {
            'priority': {'description': 'Priority level'},
          },
        },

        // Task status
        'taskStatusMessage':
            '{status, select, notStarted{Task not started} inProgress{Task in progress} completed{Task completed} overdue{Task overdue} canceled{Task canceled} other{Task status unknown}}',
        '@taskStatusMessage': {
          'description': 'Task status message',
          'placeholders': {
            'status': {'description': 'Current task status'},
          },
        },

        // Product availability
        'productAvailability':
            '{availability, select, inStock{In stock} outOfStock{Out of stock} preorder{Available for preorder} discontinued{Discontinued} other{Product status unknown}}',
        '@productAvailability': {
          'description': 'Product availability status',
          'placeholders': {
            'availability': {'description': 'Current product availability'},
          },
        },

        // User role
        'userRoleDescription':
            '{role, select, admin{Administrator} editor{Editor} viewer{Viewer} guest{Guest} other{Unknown role}}',
        '@userRoleDescription': {
          'description': 'User role description',
          'placeholders': {
            'role': {'description': "User's role"},
          },
        }, // General app-wide strings
        '@appName': {'description': 'The name of the application'},

        'commonLoading': 'Loading...',
        '@commonLoading': {'description': 'Loading message displayed during data retrieval'},

        'pageLoginButton': 'Login',
        '@pageLoginButton': {'description': 'Login button label'},

        // Home page
        'pageHomeWelcome': 'Welcome {userName}',
        '@pageHomeWelcome': {
          'description': 'Welcome message on the Home screen',
          'placeholders': {
            'userName': {'description': "User's name"},
          },
        },
        'pageHomeNewNotifications':
            '{count, plural, =0{No new notifications} one{You have 1 new notification} other{You have {count} new notifications}}',
        '@pageHomeNewNotifications': {
          'description': 'New notifications count on the Home screen',
          'placeholders': {
            'count': {'description': 'Number of new notifications'},
          },
        },

        'pageHomeTaskStatus':
            '{status, select, pending{Pending tasks} completed{Completed tasks} overdue{Overdue tasks} other{Tasks}}',
        '@pageHomeTaskStatus': {
          'description': 'Task status message on the Home screen',
          'placeholders': {
            'status': {'description': 'Task status'},
          },
        },
        // Product details
        'productPrice': 'Price: {price}',
        '@productPrice': {
          'description': 'Product price',
          'placeholders': {
            'price': {'type': 'double', 'format': 'currency'},
          },
        },
        // Contact details
        'contactDetailsEmailCopiedMessage': 'Email copied to clipboard: {email}',
        '@contactDetailsEmailCopiedMessage': {
          'description': 'Snackbar message when email is copied',
          'placeholders': {
            'email': {'type': 'String', 'example': 'example@gmail.com'},
          },
        },

        // Forms
        'formSubmitButton': 'Submit',
        '@formSubmitButton': {'description': 'Submit button label'},
        'confirmationDialogRemoveItem': '{count, plural, =1{Remove this item?} other{Remove {count} items?}}',
        '@confirmationDialogRemoveItem': {
          'description': 'Confirmation dialog for removing items',
          'placeholders': {
            'count': {'type': 'int'},
          },
        },
      };
      //  *
      test(
        '''
fromArb()
      should find all messages with `plural` keyword in fakeArb map.''',
        () {
          /// keys wich wu looking for onto feke json file
          final keys = <String>[
            'confirmationDialogRemoveItem',
            'pageHomeNewNotifications',
            'pageHomeInboxCount',
            'remove_all_done_dialog_body',
            'roomUnavailableContactOrganiserDialogCount',
          ];
          final result = <String, PuralArb>{};
          for (final entry in fakeArb.entries) {
            if (plural.maatchForStr(entry) != null) result.addAll(plural.fromArb(entry)!);
          }
          expect(result.keys.every(keys.contains), isTrue);
        },
      );
      // *
      test('''
toSingleStr()
      return lingle string == should pass. ''', () {
        final fakeParsedArb = <String, PuralArb>{
          'painters': const PuralArb({
            'first': 'morning',
            'second': 'noon',
            'third': 'afternoon',
            'fourth': 'evening',
            'other': 'night',
          }, <String>[
            'day_period',
          ]),
        };
        final buff = StringBuffer();
        for (final element in fakeParsedArb.entries) {
          buff.write(plural.toSingleStr(element));
        }
        expect(buff.toString(), isNot(isEmpty));
      });

      // *
      test('''
fromArb()
      should find all ICU Select messages''', () {
        final keys = <String>[
          'pageHomeInboxCount',
          'roomUnavailableContactOrganiserDialogCount',
          'remove_all_done_dialog_body',
          'pageHomeNewNotifications',
          'confirmationDialogRemoveItem',
        ];
        final result = <String, PuralArb>{};
        for (final entry in fakeArb.entries) {
          if (plural.maatchForStr(entry) != null) result.addAll(plural.fromArb(entry)!);
        }
        expect(result.length, keys.length);
        expect(result.keys.every(keys.contains), isTrue);
      });
      // *
      test('''
toSingleStr()
      ''', () {
        //
        final fakeParsedArb = <String, PuralArb>{
          'globalKey': const PuralArb({
            'first': 'morning',
            'second': 'noon',
            'third': 'afternoon',
            'fourth': 'evening',
            'other': 'night',
          }, <String>[
            'period',
          ]),
        };
        final buff = StringBuffer();
        for (final entry in fakeParsedArb.entries) {
          buff.write(plural.toSingleStr(entry));
        }
       // expect(buff.toString().contains(plural), isTrue);
        // final List<String> _translatedChank = _buff.toString().split(_plural.separator);
        // final Map<String, dynamic> map = _plural.toArb(parsedChank, _translatedChank, _globalKey);
      });
    });

    // *
//     test('''
// separeteTranslation()
//       lenght must be the same as map''', () {
//       final fakeParsedArb = <String, PuralArb>{
//         'globalKey': PuralArb({
//           'first': 'morning',
//           'second': 'noon',
//           'third': 'afternoon',
//           'fourth': 'evening',
//           'other': 'night',
//         }, <String>[
//           'period',
//         ]),
//       };
//       final buff = StringBuffer();
//       for (final entry in fakeParsedArb.entries) {
//         buff.write(plural.toSingleStr(entry));
//       }

//       // var f = plural.separeteTranslation(buff.toString()).length;
//       // print(plural.separeteTranslation(buff.toString()).toList());
//       final tr = plural.separeteTranslation(buff.toString()).toList()..removeLast();
//       expect(
//         (tr.length) == fakeParsedArb.values.first.source.length,
//         isTrue,
//       );
//     });


  });
}
