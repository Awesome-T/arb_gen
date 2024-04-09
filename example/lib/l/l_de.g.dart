import 'package:intl/intl.dart' as intl;

import 'l.g.dart';

/// The translations for German (`de`).
class LDe extends L {
  LDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => 'Dein Benutzername';

  @override
  String get pageLoginPassword => 'Ihr Passwort';

  @override
  String pageHomeTitle(Object firstName) {
    return 'Willkommen $firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sie haben $count neue Nachrichten',
      one: 'Sie haben 1 neue Nachricht',
      zero: 'Sie haben keine neuen Nachrichten',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Sein Geburtstag',
        'female': 'Ihr Geburtstag',
        'other': 'Ihr Geburtstag',
      },
    );
    return '$_temp0';
  }

  @override
  String commonVehicleType(String vehicleType) {
    String _temp0 = intl.Intl.selectLogic(
      vehicleType,
      {
        'sedan': 'Limousine',
        'cabriolet': 'Cabriolet mit festem Dach',
        'truck': 'LKW mit 16 Rädern',
        'other': 'Andere',
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

    return 'Ihr Guthaben beträgt am $amountString $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Benutzerdefiniertes Datumsformat: $dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return 'Kosten Kosten';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Erstellt: $dateString';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Veranstalter',
      one: 'ein Organisator',
    );
    return '$_temp0';
  }

  @override
  String get singleString => 'Dies ist nur eine normale Zeichenfolge.';

  @override
  String get datePickerMinuteOne => '1 Minute';

  @override
  String get datePickerMinuteOther => '\$minute Minuten';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return '$email in die Zwischenablage kopiert';
  }

  @override
  String get formLabelDone => 'Erledigt';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'Hallo Administrator!',
        'manager': 'Hallo Manager!',
        'other': 'Hallo Besucher!',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return 'Möchten Sie die Einkaufsliste „$list_name“ wirklich löschen? Dieser Vorgang kann nicht rückgängig gemacht werden.';
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
          'Sind Sie sicher, dass Sie alle $countString Elemente entfernen möchten? Dieser Vorgang kann nicht rückgängig gemacht werden.',
      one:
          'Sind Sie sicher, dass Sie ein Element entfernen möchten? Dieser Vorgang kann nicht rückgängig gemacht werden.',
    );
    return '$_temp0';
  }
}
