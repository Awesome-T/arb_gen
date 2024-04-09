import 'package:intl/intl.dart' as intl;

import 'l.g.dart';

/// The translations for Chinese (`zh`).
class LZh extends L {
  LZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Demo app';

  @override
  String get pageLoginUsername => '您的用户名';

  @override
  String get pageLoginPassword => '你的密码';

  @override
  String pageHomeTitle(Object firstName) {
    return '欢迎$firstName';
  }

  @override
  String pageHomeInboxCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '您有 $count 条新消息',
      one: '您有 1 条新消息',
      zero: '您没有新消息',
    );
    return '$_temp0';
  }

  @override
  String pageHomeBirthday(String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': '他的生日',
        'female': '她的生日',
        'other': '他们的生日',
      },
    );
    return '$_temp0';
  }

  @override
  String commonVehicleType(String vehicleType) {
    String _temp0 = intl.Intl.selectLogic(
      vehicleType,
      {
        'sedan': '轿车',
        'cabriolet': '实心车顶敞篷车',
        'truck': '16轮卡车',
        'other': '其他',
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

    return '您在 $amountString 的余额为 $dateString';
  }

  @override
  String commonCustomDateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('EEE, M/d/y', localeName);
    final String dateString = dateDateFormat.format(date);

    return '自定义日期格式：$dateString';
  }

  @override
  String productCostInfo(double cost) {
    final intl.NumberFormat costNumberFormat = intl.NumberFormat.currency(
        locale: localeName, symbol: '€', decimalDigits: 3);
    final String costString = costNumberFormat.format(cost);

    return '成本：$costString';
  }

  @override
  String postCreatedInfo(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '创建日期';
  }

  @override
  String roomUnavailableContactOrganiserDialogCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '组织者',
      one: '组织者',
    );
    return '$_temp0';
  }

  @override
  String get singleString => '这只是一个普通的字符串。';

  @override
  String get datePickerMinuteOne => '1分钟';

  @override
  String get datePickerMinuteOther => '\$分钟 分钟';

  @override
  String contactDetailsPopupEmailCopiedMessage(String email) {
    return '已将 $email 复制到剪贴板';
  }

  @override
  String get formLabelDone => '完毕';

  @override
  String pageHomeWelcomeRole(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': '管理员您好！',
        'manager': '经理您好！',
        'other': '访客您好！',
      },
    );
    return '$_temp0';
  }

  @override
  String delete_shopping_list_dialog_body(String list_name) {
    return '您确实要删除 $list_name 购物清单吗？此操作无法撤消。';
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
      other: '您确定要删除所有 $countString 项吗？此操作无法撤消。',
      one: '您确定要删除 1 件商品吗？此操作无法撤消。',
    );
    return '$_temp0';
  }
}
