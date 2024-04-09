import 'dart:async';

import 'package:example/app.dart';
import 'package:example/core/localization/presentation/notifier.dart';
import 'package:example/core/localization/repo/lds/lds.dart';
import 'package:example/core/localization/repo/localization_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        final prefs = await SharedPreferences.getInstance();
        runApp(
          InhLNotifier(
            notifier: LNotifier(
              repoImpl: ILocalizationRepo.impl(
                prefs: LDS(prefs),
              ),
            ),
            child: const App(),
          ),
        );
      },
      (error, stack) => runApp(
        WidgetsApp(
          color: const Color.fromARGB(219, 246, 240, 240),
          home: ErrorWidget('$error\n$stack'),
        ),
      ),
    );

/**
  "sq",
    "ar",
    "hy",
    "az",
    "eu",
    "be",
    "bn",
    "bs",
    "bg",
 
    "hr",
    "cs",
    "da",
    "nl",
    "en",
    "et",
    "tl",
    "fi",
    "fr",
    "gl",
    "ka",
    "de",
    "el",
    "gu",
    "ht",
    "ha",
    "haw",
    "hi",
    "hmn",
    "hu",
    "is",
    "ig",
    "id",
    "ga",
    "it",
    "ja",

    "kn",
    "kk",
    "km",
    "rw",
    "ko",
    "ku",
    "ky",
    "lo",
    "la",
    "lv",
    "lt",
    "lb",
    "mk",
    "mg",
    "ms",
    "ml",
    "mt",
    "mi",
    "mr",
    "mn",
    "my",
    "ne",
    "no",
    "ps",
    "fa",
    "pl",
    "pt",
    "pa",
    "ro",
    "ru",
    "sm",
    "gd",
    "sr",
    "st",
    "sn",
    "sd",
    "si",
    "sk",
    "sl",
    "so",
    "es",
    "su",
    "sw",
    "sv",
    "tg",
    "ta",
    "te",
    "th",
    "tr",
    "uk",
    "ur",
    "ug",
    "uz",
    "vi",
    "cy",
    "xh",
    "yi",
    "yo",
    "zu",
    "tt",
    "tk"
 */
