import 'package:intl/intl.dart' as intl;

import 'localization.dart';

/// The translations for Italian (`it`).
class AppLocalezationIt extends AppLocalezation {
  AppLocalezationIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => 'Il tuo nome utente';

  @override
  String get pageLoginPassword => 'La tua password';

  @override
  String pageHomeTitle(Object firstName) {
    return 'Benvenuto $firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hai $count nuovi messaggi',
      one: 'Hai 1 nuovo messaggio',
      zero: 'Non hai nuovi messaggi',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Il suo compleanno',
        'female': 'Il suo compleanno',
        'other': 'Il loro compleanno',
      },
    );
    return '$_temp0';
  }

  @override
  String commonVehicleType(String vehicleType) {
    String _temp0 = intl.Intl.selectLogic(
      vehicleType,
      {
        'sedan': 'Berlina',
        'cabriolet': 'Cabriolet con tetto solido',
        'truck': 'Carrello a 16 ruote',
        'other': 'Altro',
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

    return 'Il tuo saldo è di $amountString il $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Formato data personalizzato: $dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return 'Costo: $costString';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data di Creazione';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'organizzatori',
      one: 'un organizzatore',
    );
    return '$_temp0';
  }

  @override
  String get singleString => 'Questa è solo una stringa normale.';

  @override
  String get datePickerMinuteOne => '1 minuto';

  @override
  String get datePickerMinuteOther => '\$minuto minuti';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return 'Copiato $email negli appunti';
  }

  @override
  String get formLabelDone => 'Fatto';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'Ciao amministratore!',
        'manager': 'Ciao direttore!',
        'other': 'Ciao visitatore!',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return 'Vuoi davvero eliminare la lista della spesa di $list_name? Questa operazione non può essere annullata.';
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
          'Sei sicuro di voler rimuovere tutti i $countString elementi? Questa operazione non può essere annullata.',
      one:
          'Sei sicuro di voler rimuovere 1 articolo? Questa operazione non può essere annullata.',
    );
    return '$_temp0';
  }
}
