import 'dart:async';
import 'package:example/app.dart';
import 'package:example/core/localization_/repo/lds/lds.dart';
import 'package:example/core/localization_/repo/localization_repo.dart';
import 'package:example/core/localization_/presentation/notifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        final _prefs = await SharedPreferences.getInstance();
        runApp(
          InhLNotifier(
            notifier: LNotifier(
              repoImpl: ILocalizationRepo.impl(
                prefs: LDS(_prefs),
              ),
            ),
            child: App(),
          ),
        );
      },
      (error, stack) => runApp(
        WidgetsApp(
         color: Color.fromARGB(219, 246, 240, 240),
          home: ErrorWidget('$error\n$stack'),
        ),
      ),
    );
