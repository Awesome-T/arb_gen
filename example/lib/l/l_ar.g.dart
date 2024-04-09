import 'package:intl/intl.dart' as intl;

import 'l.g.dart';

/// The translations for Arabic (`ar`).
class LAr extends L {
  LAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => 'اسم المستخدم الخاص بك';

  @override
  String get pageLoginPassword => 'كلمة السر خاصتك';

  @override
  String pageHomeTitle(Object firstName) {
    return 'مرحبًا $firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لديك $count من الرسائل الجديدة',
      one: 'لديك 1 رسالة جديدة',
      zero: 'ليس لديك رسائل جديدة',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'عيد ميلاده',
        'female': 'عيد ميلادها',
        'other': 'عيد ميلادهم',
      },
    );
    return '$_temp0';
  }

  @override
  String commonVehicleType(String vehicleType) {
    String _temp0 = intl.Intl.selectLogic(
      vehicleType,
      {
        'sedan': 'سيدان',
        'cabriolet': 'سقف كابريوليه صلب',
        'truck': 'شاحنة ذات 16 عجلة',
        'other': 'آخر',
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

    return 'رصيدك هو $amountString في $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'تنسيق التاريخ المخصص: $dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return 'التكلفة التكلفة';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'تاريخ الإنشاء';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'المنظمون',
      one: 'منظم',
    );
    return '$_temp0';
  }

  @override
  String get singleString => 'هذه مجرد سلسلة عادية.';

  @override
  String get datePickerMinuteOne => '1 دقيقة';

  @override
  String get datePickerMinuteOther => 'دقيقة \$';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return 'تم نسخ $email إلى الحافظة';
  }

  @override
  String get formLabelDone => 'منتهي';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'مرحبا المشرف!',
        'manager': 'مرحبا مدير!',
        'other': 'مرحبا الزائر!',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return 'هل تريد حقًا حذف قائمة التسوق $list_name؟ هذه العملية لا يمكن التراجع عنها.';
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
          'هل أنت متأكد أنك تريد إزالة جميع العناصر الـ $countString؟ هذه العملية لا يمكن التراجع عنها.',
      one:
          'هل أنت متأكد أنك تريد إزالة عنصر واحد؟ هذه العملية لا يمكن التراجع عنها.',
    );
    return '$_temp0';
  }
}
