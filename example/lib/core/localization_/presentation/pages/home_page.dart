import 'package:example/core/localization_/presentation/pages/lang_select.dart';
import 'package:example/localization/localization.g.dart';
import 'package:example/core/localization_/presentation/notifier.dart';
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
          title: Text(AppLocalezation.of(context).appName),
          leading: FittedBox(
            child: IconButton(
              icon: Row(
                children: [
                  Icon(Icons.language),
                  Text(AppLocalezation.of(context).localeName),
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
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  ColoredBox(
                    color: Color.fromARGB(239, 244, 213, 240),
                    child: Column(
                      children: [
                        Text('Lang', style: Theme.of(context).textTheme.headlineSmall),
                        Text('code: ${AppLocalezation.of(context).localeName}'),
                        Text(
                            'language ${InhLNotifier.of(context).langs[AppLocalezation.of(context).localeName]!.keys.first}'),
                        Divider(),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    color: Color.fromARGB(238, 213, 244, 217),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text('Not translated', style: Theme.of(context).textTheme.headlineSmall),
                        Txt(AppLocalezation.of(context).appName),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ColoredBox(
                    color: Color.fromARGB(221, 199, 235, 234),
                    child: Column(
                      children: [
                        Divider(),
                        Text('Translated', style: Theme.of(context).textTheme.headlineSmall),
                        Txt(AppLocalezation.of(context).pageLoginPassword),
                        Txt(AppLocalezation.of(context).pageLoginUsername),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ColoredBox(
                    color: Color.fromARGB(204, 222, 170, 222),
                    child: Column(
                      children: [
                        Divider(),
                        Text('DT Format', style: Theme.of(context).textTheme.headlineSmall),
                        Txt(AppLocalezation.of(context).postCreatedInfo(DateTime.now())),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ColoredBox(
                    color: Color.fromARGB(233, 209, 243, 187),
                    child: Column(
                      children: [
                        Divider(),
                        Text('KEYWORD: select', style: Theme.of(context).textTheme.headlineMedium),
                        Text('sedan, cabriolet, truck or other', style: Theme.of(context).textTheme.bodyMedium),
                        Row(children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _controllerSelect1,
                              decoration: const InputDecoration(),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: ValueListenableBuilder(
                                valueListenable: _controllerSelect1,
                                builder: (_, value, __) =>
                                    Txt(AppLocalezation.of(context).commonVehicleType('${value.text}')),
                              ),
                            ),
                          ),
                        ]),
                        Padding(padding: EdgeInsets.only(top: 8)),
                        Text('admin, manager or other', style: Theme.of(context).textTheme.bodyMedium),
                        Row(children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _controllerSelect2,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: ValueListenableBuilder(
                                valueListenable: _controllerSelect2,
                                builder: (_, value, __) =>
                                    Txt(AppLocalezation.of(context).pageHomeWelcomeRole('${value.text}')),
                              ),
                            ),
                          )
                        ]),
                        Divider(),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ColoredBox(
                    color: Color.fromARGB(66, 164, 157, 221),
                    child: Column(
                      children: [
                        Text('KEYWORD: plural', style: Theme.of(context).textTheme.headlineMedium),
                        Text('=1, other', style: Theme.of(context).textTheme.bodyMedium),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
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
                                  return Txt(AppLocalezation.of(context)
                                      .remove_all_done_dialog_body(int.tryParse(value.text) ?? 0));
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 8)),
                        Text('1, other', style: Theme.of(context).textTheme.bodyMedium),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
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
                                builder: (___, value, __) => Txt(AppLocalezation.of(context)
                                    .roomUnavailableContactOrganiserDialogCount(int.tryParse(value.text) ?? 0)),
                              ),
                            )
                          ],
                        )
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
