import 'package:example/core/localization/presentation/notifier.dart';
import 'package:example/core/localization/presentation/pages/lang_select.dart';
import 'package:example/localization/localization.g.dart';
import 'package:flutter/material.dart';

///
///
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controllerSelect1;
  late TextEditingController _controllerSelect2;
  late TextEditingController _controllerSelect3;
  late TextEditingController _controllerSelect4;
  @override
  void initState() {
    super.initState();
    _controllerSelect1 = TextEditingController();
    _controllerSelect2 = TextEditingController();
    _controllerSelect3 = TextEditingController();
    _controllerSelect4 = TextEditingController();
  }

  @override
  void dispose() {
    _controllerSelect1.dispose();
    _controllerSelect2.dispose();
    _controllerSelect3.dispose();
    _controllerSelect4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(L.of(context).appName),
          leading: FittedBox(
            child: IconButton(
              icon: Row(
                children: [
                  const Icon(Icons.language),
                  Text(L.of(context).localeName),
                ],
              ),
              onPressed: () async => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const LangSelect(),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                children: [
                  ColoredBox(
                    color: const Color.fromARGB(239, 244, 213, 240),
                    child: Column(
                      children: [
                        Text(
                          'Lang',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text('code: ${L.of(context).localeName}'),
                        Text(
                          'language ${InhLNotifier.of(context).langs[L.of(context).localeName]!.keys.first}',
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    color: const Color.fromARGB(238, 213, 244, 217),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'Not translated',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Txt(L.of(context).appName),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ColoredBox(
                    color: const Color.fromARGB(221, 199, 235, 234),
                    child: Column(
                      children: [
                        const Divider(),
                        Text(
                          'Translated',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Txt(L.of(context).pageLoginPassword),
                        Txt(L.of(context).pageLoginUsername),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ColoredBox(
                    color: const Color.fromARGB(204, 222, 170, 222),
                    child: Column(
                      children: [
                        const Divider(),
                        Text(
                          'DT Format',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Txt(
                          L.of(context).postCreatedInfo(DateTime.now()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ColoredBox(
                    color: const Color.fromARGB(233, 209, 243, 187),
                    child: Column(
                      children: [
                        const Divider(),
                        Text(
                          'KEYWORD: select',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'sedan, cabriolet, truck or other',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controllerSelect1,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: _controllerSelect1,
                                  builder: (_, value, __) => Txt(
                                    L.of(context).commonVehicleType(value.text),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          'admin, manager or other',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controllerSelect2,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: _controllerSelect2,
                                  builder: (_, value, __) => Txt(
                                    L
                                        .of(context)
                                        .pageHomeWelcomeRole(value.text),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ColoredBox(
                    color: const Color.fromARGB(66, 164, 157, 221),
                    child: Column(
                      children: [
                        Text(
                          'KEYWORD: plural',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '=1, other',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _controllerSelect3,
                                maxLength: 2,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ValueListenableBuilder(
                                valueListenable: _controllerSelect3,
                                builder: (_, value, __) {
                                  return Txt(
                                    L.of(context).remove_all_done_dialog_body(
                                          int.tryParse(value.text) ?? 0,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          '1, other',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _controllerSelect4,
                                maxLength: 2,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ValueListenableBuilder(
                                valueListenable: _controllerSelect4,
                                builder: (___, value, __) => Txt(
                                  L
                                      .of(context)
                                      .roomUnavailableContactOrganiserDialogCount(
                                        int.tryParse(value.text) ?? 0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

///
///
///
class Txt extends StatelessWidget {
  ///
  const Txt(this.txt, {super.key});
  final String txt;
  @override
  Widget build(BuildContext context) => Text(
        txt,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
            ),
      );
}
