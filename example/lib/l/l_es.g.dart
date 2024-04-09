import 'package:intl/intl.dart' as intl;

import 'l.g.dart';

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => 'Su nombre de usuario';

  @override
  String get pageLoginPassword => 'Tu contraseña';

  @override
  String pageHomeTitle(Object firstName) {
    return 'Bienvenido $firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tienes $count mensajes nuevos',
      one: 'Tienes 1 mensaje nuevo',
      zero: 'No tienes mensajes nuevos',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Su cumpleaños',
        'female': 'Su cumpleaños',
        'other': 'su cumpleaños',
      },
    );
    return '$_temp0';
  }

  @override
  String commonVehicleType(String vehicleType) {
    String _temp0 = intl.Intl.selectLogic(
      vehicleType,
      {
        'sedan': 'Sedán',
        'cabriolet': 'Cabriolet con techo macizo',
        'truck': 'camión de 16 ruedas',
        'other': 'Otro',
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

    return 'Su saldo es $amountString el $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Formato de fecha personalizado: $dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return 'Costo costo';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Fecha de creación';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'organizadores',
      one: 'un organizador',
    );
    return '$_temp0';
  }

  @override
  String get singleString => 'Esta es sólo una cadena normal.';

  @override
  String get datePickerMinuteOne => '1 minuto';

  @override
  String get datePickerMinuteOther => '\$minuto minutos';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return 'Copiado $email al portapapeles';
  }

  @override
  String get formLabelDone => 'Hecho';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'Hola administrador!',
        'manager': 'Hola gerente!',
        'other': 'Hola visitante!',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return '¿Realmente deseas eliminar la lista de compras de $list_name? Esta operación no se puede deshacer.';
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
          '¿Está seguro de que desea eliminar todos los $countString elementos? Esta operación no se puede deshacer.',
      one:
          '¿Estás seguro de que deseas eliminar 1 elemento? Esta operación no se puede deshacer.',
    );
    return '$_temp0';
  }
}
