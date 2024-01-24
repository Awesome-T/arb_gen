import 'package:example/core/localyze/presentation/notifier.dart';
import 'package:example/core/localyze/presentation/pages/home_page.dart';
import 'package:example/localization/localization.g.dart';
import 'package:flutter/material.dart';

///
///
class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        supportedLocales: AppLocalization.supportedLocales,
        localizationsDelegates: AppLocalization.localizationsDelegates,
        localeListResolutionCallback: (_, __) =>
            InhLNotifier.of(context).locate,
        localeResolutionCallback: (_, __) => InhLNotifier.of(context).locate,
        locale: InhLNotifier.of(context).locate,
        home: const HomePage(),
      );
}
