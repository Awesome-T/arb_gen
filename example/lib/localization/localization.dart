import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localization_en.dart';
import 'localization_it.dart';

/// Callers can lookup localized strings with an instance of AppLocalezation
/// returned by `AppLocalezation.of(context)`.
///
/// Applications need to include `AppLocalezation.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalezation.localizationsDelegates,
///   supportedLocales: AppLocalezation.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalezation.supportedLocales
/// property.
abstract class AppLocalezation {
  AppLocalezation(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalezation of(BuildContext context) {
    return Localizations.of<AppLocalezation>(context, AppLocalezation)!;
  }

  static const LocalizationsDelegate<AppLocalezation> delegate =
      _AppLocalezationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Demo app'**
  String get appName;

  /// No description provided for @pageLoginUsername.
  ///
  /// In en, this message translates to:
  /// **'Your username'**
  String get pageLoginUsername;

  /// No description provided for @pageLoginPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get pageLoginPassword;

  /// Welcome message on the Home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome {firstName}'**
  String pageHomeTitle(Object firstName);

  /// New messages count on the Home screen
  ///
  /// In en, this message translates to:
  /// **'{count,plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}'**
  String pageHomeInboxCount(num count);

  /// Birthday message on the Home screen
  ///
  /// In en, this message translates to:
  /// **'{sex, select, male{His birthday} female{Her birthday} other{Their birthday}}'**
  String pageHomeBirthday(String sex);

  /// Vehicle type
  ///
  /// In en, this message translates to:
  /// **'{vehicleType, select, sedan{Sedan} cabriolet{Solid roof cabriolet} truck{16 wheel truck} other{Other}}'**
  String commonVehicleType(String vehicleType);

  /// No description provided for @pageHomeBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance is {amount} on {date}'**
  String pageHomeBalance(double amount, DateTime date);

  /// No description provided for @commonCustomDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Custom date format: {date}'**
  String commonCustomDateFormat(DateTime date);

  /// No description provided for @productCostInfo.
  ///
  /// In en, this message translates to:
  /// **'Cost: {cost}'**
  String productCostInfo(double cost);

  /// No description provided for @postCreatedInfo.
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String postCreatedInfo(DateTime date);

  /// No description provided for @roomUnavailableContactOrganiserDialogCount.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =1{an organiser} other{organisers}}'**
  String roomUnavailableContactOrganiserDialogCount(num count);

  /// Comment for the single string.
  ///
  /// In en, this message translates to:
  /// **'This is just a normal string.'**
  String get singleString;

  /// No description provided for @datePickerMinuteOne.
  ///
  /// In en, this message translates to:
  /// **'1 minute'**
  String get datePickerMinuteOne;

  /// No description provided for @datePickerMinuteOther.
  ///
  /// In en, this message translates to:
  /// **'\$minute minutes'**
  String get datePickerMinuteOther;

  /// Message being displayed in a snackbar upon long-clicking email in contact details popup
  ///
  /// In en, this message translates to:
  /// **'Copied {email} to clipboard'**
  String contactDetailsPopupEmailCopiedMessage(String email);

  /// Label being displayed below every form field that is filled and valid
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get formLabelDone;

  /// No description provided for @pageHomeWelcomeRole.
  ///
  /// In en, this message translates to:
  /// **'{role, select, admin{Hi admin!} manager{Hi manager!} other{Hi visitor!}}'**
  String pageHomeWelcomeRole(String role);

  /// No description provided for @delete_shopping_list_dialog_body.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete {list_name} shopping list? This operation cannot be undone.'**
  String delete_shopping_list_dialog_body(String list_name);

  /// No description provided for @remove_all_done_dialog_body.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =1{Are you sure you want to remove 1 item? This operation cannot be undone.} other{Are you sure you want to remove all {count} items? This operation cannot be undone.}}'**
  String remove_all_done_dialog_body(int count);
}

class _AppLocalezationDelegate extends LocalizationsDelegate<AppLocalezation> {
  const _AppLocalezationDelegate();

  @override
  Future<AppLocalezation> load(Locale locale) {
    return SynchronousFuture<AppLocalezation>(lookupAppLocalezation(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalezationDelegate old) => false;
}

AppLocalezation lookupAppLocalezation(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalezationEn();
    case 'it':
      return AppLocalezationIt();
  }

  throw FlutterError(
      'AppLocalezation.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
