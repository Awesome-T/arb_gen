import 'package:intl/intl.dart' as intl;

import 'l.g.dart';

/// The translations for French (`fr`).
class LFr extends L {
  LFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => 'Ton nom d\'utilisateur';

  @override
  String get pageLoginPassword => 'Votre mot de passe';

  @override
  String pageHomeTitle(Object firstName) {
    return 'Bienvenue $firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vous avez $count nouveaux messages',
      one: 'Vous avez 1 nouveau message',
      zero: 'Vous n\'avez pas de nouveaux messages',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Son anniversaire',
        'female': 'Son anniversaire',
        'other': 'Leur anniversaire',
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
        'cabriolet': 'Cabriolet à toit solide',
        'truck': 'camion 16 roues',
        'other': 'Autre',
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

    return 'Votre solde est de $amountString le $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Format de date personnalisé : $dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return 'Coût coût';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Créé : $dateString';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'les organisateurs',
      one: 'un organisateur',
    );
    return '$_temp0';
  }

  @override
  String get singleString => 'C\'est juste une chaîne normale.';

  @override
  String get datePickerMinuteOne => '1 minute';

  @override
  String get datePickerMinuteOther => '\$minute minutes';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return 'Copié $email dans le presse-papiers';
  }

  @override
  String get formLabelDone => 'Fait';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'Salut l\'administrateur !',
        'manager': 'Salut le directeur !',
        'other': 'Salut visiteur !',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return 'Voulez-vous vraiment supprimer la liste de courses $list_name ? Cette opération ne peut pas être annulée.';
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
          'Voulez-vous vraiment supprimer tous les $countString éléments ? Cette opération ne peut pas être annulée.',
      one:
          'Êtes-vous sûr de vouloir supprimer 1 élément ? Cette opération ne peut pas être annulée.',
    );
    return '$_temp0';
  }
}
