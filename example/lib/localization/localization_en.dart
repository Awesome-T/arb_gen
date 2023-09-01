import 'package:intl/intl.dart' as intl;

import 'localization.dart';

/// The translations for English (`en`).
class AppLocalezationEn extends AppLocalezation {
  AppLocalezationEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => 'Your username';

  @override
  String get pageLoginPassword => 'Your password';

  @override
  String pageHomeTitle(Object firstName) {
    return 'Welcome $firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count new messages',
      one: 'You have 1 new message',
      zero: 'You have no new messages',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'His birthday',
        'female': 'Her birthday',
        'other': 'Their birthday',
      },
    );
    return '$_temp0';
  }

  @override
  String commonVehicleType(String vehicleType) {
    String _temp0 = intl.Intl.selectLogic(
      vehicleType,
      {
        'sedan': 'Sedan',
        'cabriolet': 'Solid roof cabriolet',
        'truck': '16 wheel truck',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String pageHomeBalance(double amount, DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.currency(
        locale: localeName,
        decimalDigits: 2,
        name: 'USD',
        symbol: '\$',
        customPattern: '¤#0.00');
    final String amountString = amountNumberFormat.format(amount);

    return 'Your balance is $amountString on $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Custom date format: $dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return 'Cost: $costString';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Created: $dateString';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'organisers',
      one: 'an organiser',
    );
    return '$_temp0';
  }

  @override
  String get singleString => 'This is just a normal string.';

  @override
  String get datePickerMinuteOne => '1 minute';

  @override
  String get datePickerMinuteOther => '\$minute minutes';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return 'Copied $email to clipboard';
  }

  @override
  String get formLabelDone => 'Done';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'Hi admin!',
        'manager': 'Hi manager!',
        'other': 'Hi visitor!',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return 'Do you really want to delete $list_name shopping list? This operation cannot be undone.';
  }

  @override
  String remove_all_done_dialog_body(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compactLong(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Are you sure you want to remove all $countString items? This operation cannot be undone.',
      one:
          'Are you sure you want to remove 1 item? This operation cannot be undone.',
    );
    return '$_temp0';
  }
}
