import 'package:example/core/localization_/repo/localization_repo.dart';
import 'package:example/core/localization_/repo/params.dart';
import 'package:flutter/widgets.dart';

/// 
/// The `LNotifier` class extends `ChangeNotifier` and handles localization updates.
/// 
class LNotifier extends ChangeNotifier {
  ///
  final ILocalizationRepo _repoImpl;
  LNotifier({
    required ILocalizationRepo repoImpl,
  }) : _repoImpl = repoImpl {
    init(LoadLocaleUCParam());
  }

  /// Initializes the localization notifier by loading the language code.
  void init(LoadLocaleUCParam param) {
    _repoImpl.loadLandCode(param).then<void>(
      (String? l) {
        late String _code;
        if (l != null) {
          _code = l;
        } else {
          _code = langs.keys.contains('en') ? 'en' : langs.keys.first;
          _repoImpl.udateLangCode(UpdateLocaleUCParam(code: _code));
        }
        _locate = Locale(_code);
        notifyListeners();
      },
    );
  }

  /// Returns the supported language mappings.
  Map<String, Map<String, String>> get langs => _repoImpl.langs;

  late Locale _locate;

  /// Gets the current locale.
  Locale get locate => _locate;

  /// Updates the localization based on the provided locale.
  void updateLocalization(String locale) async {
    (locale != _locate.languageCode)
        ? _repoImpl.udateLangCode(UpdateLocaleUCParam(code: locale)).then(
            (_) {
              _locate = Locale(locale);
              notifyListeners();
            },
          )
        : null;
  }
}

///
///
///
class InhLNotifier extends InheritedNotifier<LNotifier> {
  const InhLNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  /// get access the `LNotifier` instance from the widget tree.
  static LNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InhLNotifier>()!.notifier!;
  }
}