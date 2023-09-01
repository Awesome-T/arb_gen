import 'dart:async';
import 'dart:io';
import '../src/arb_gen.dart';
import '../src/parser/parser_arb.dart';

///
Future<void> main(List<String> arguments) async {
  final sWatch = Stopwatch()..start();
  // * Translator - это класс, используемый для реализации API-вызовов,
  // *  чтобы осуществить процедуру перевода.
  late final ServiceTranslator translator;

  // Check if the configuration is ready to be loaded
  // from a file (arb.gen/config.json).
  if (!Config.isFileCofigExist) {
    throw const ConfigArgException("File with cofig's not exist");
  }
  //
  const reader = FileReader();
  // [1] Configuration Loading:    _configInit(arguments);
  late final cotnig = Config.load(reader.loadMapFromFile('arb.gen/config.json'));
  // [2] Loading ARB/JSON Data:
  // * Load the ARB/JSON content from the specified path (_cotnig.pathToOriginSource).
  // * IFileReader использует метод loadMapFromFile для загрузки Map из файла.
  // Этот метод читает файл, содержащий JSON-данные, и возвращает Map,
  // соответствующую JSON-данным.
  // final filrereader= IFileReader();
  final arbContent = reader.loadMapFromFile(cotnig.pathToFile);
  // * ParserArb - это класс, используемый для преобразования
  // * ARB/JSON-контента в формат Dart. DTArb - это класс,
  // * используемый для хранения ARB/JSON-контента.
  final parseing = ParserArb(cotnig, arbContent);
  //     Pprocessing(
  //   cotnig,
  //   arbContent,
  //   SelectPaser(const SelectInnerParser()),
  //   PluralParser(const PluralInnerParser()),
  //   SimpleStrParser(),
  // );
  //
  final parsedData = parseing.fromArb;
  // Преобразует строку в карту, используя метод strToMap.
  final str = parseing.toSingleStr(parsedData);
  // * cotnig.apiKey и cotnig.translater - это параметры конфигурации,
  // * которые могут быть использованы для создания экземпляра Translator,
  // * чтобы выполнить перевод. cotnig.apiKey - это API-ключ,
  // * а cotnig.translater - сервис, с которым API-ключ связан
  // * (Google Translate, Yandex Translate).
  translator = ServiceTranslator.select(cotnig.translater, cotnig.apiKey);
  //  [3] Translation Process:
  //  * Create an instance of AbsClass to perform the translation.
  //  * Call translatedMaps on AbsClass to get a stream of translated maps.
  final transladedStream = translator.translations(str, cotnig.translateTo);
  //  * [4] Creating Translated .ARB Files:
  //  * Iterate over the stream of translated maps.
  await for (final ({String data, String lang}) item in transladedStream) {
    //
    final updatedMap = parseing.strToMap(parsedData, item.data);
    //
    final map = parseing.updeteMap((arbContent: arbContent, map: updatedMap))
      //
      ..['@@locale'] = item.lang;
    // Create translated .arb files in the specified output folder.
    await reader.createArb(cotnig.arbDir, item.lang, cotnig.arbName, map);
  }

  // * [5] Conditionally Moving Generated Files:
  // * Conditionally move the generated files to the lib folder based on the
  // allAtOnce flag in the configuration.
  if (cotnig.allAtOnce!) await _allAtOnce(cotnig);

  // * [6] Completion Message:
  final d = sWatch.elapsed;
  sWatch.stop();
  print('''--------------COMPLITE--------------
  it took  ${(d.inMilliseconds * 0.001).toStringAsFixed(2)} sec.
  ------------------------------------
  ''');
}

///
///
Future<void> _allAtOnce(Config cotnig) async {
  // Update pubspec.yaml
  // There's a commented-out section related to updating pubspec.yaml
  await upgradePubspec();
  // Creating l10n.yaml
  await createL10nyaml(
    cotnig.arbName,
    cotnig.translateTo.first,
    cotnig.outputClass,
    cotnig.lDirName,
    cotnig.preferredLanguage,
  );
  // Run flutter pub get for generating files
  await runFlutterPubGet();

  // Move to lib folder all generated files
  // It would enable that functionality.
  await moveFolderAndFiles(cotnig.lDirName);
  //
  IosUpdater.updPls(Directory.current.path, cotnig.translateTo);
  //
  createMapWithLangs(cotnig.translateTo);
}
