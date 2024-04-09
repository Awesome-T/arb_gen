import 'package:example/core/localization/presentation/notifier.dart';
import 'package:example/localization/localization.g.dart';
import 'package:flutter/material.dart';

///
///
class LangSelect extends StatefulWidget {
  ///
  const LangSelect({super.key});
  @override
  State<LangSelect> createState() => _LangSelectState();
}

class _LangSelectState extends State<LangSelect> {
  late ValueNotifier<Map<String, Map<String, String>>> _notifier;
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InhLNotifier.of(context).langs;
    _notifier = ValueNotifier(InhLNotifier.of(context).langs);
    _textEditingController.addListener(
      () {
        if (_textEditingController.text != '') {
          final entries = _notifier.value.entries.where(
            (entry) => entry.key.contains(_textEditingController.text),
          );
          final feached = Map.fromEntries(entries);
          _notifier.value = feached;
        } else {
          _notifier.value = InhLNotifier.of(context).langs;
        }
      },
    );
  }

  @override
  void dispose() {
    _notifier.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: _notifier,
            builder: (
              context,
              Map<String, Map<String, String>> value,
              _,
            ) =>
                Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    scrollPadding: const EdgeInsets.all(2),
                    decoration: InputDecoration(
                      helperMaxLines: 1,
                      suffix: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _textEditingController.clear(),
                      ),
                      prefix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => _textEditingController.clear(),
                      ),
                      border: const UnderlineInputBorder(),
                    ),
                    buildCounter: (
                      context, {
                      required currentLength,
                      required isFocused,
                      required maxLength,
                    }) =>
                        Text('$currentLength/$maxLength'),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.entries.length,
                    itemBuilder: (_, int i) {
                      final e = value.entries.toList()[i];
                      return RadioListTile<Locale>(
                        value: Locale(e.key),
                        groupValue: Locale(L.of(context).localeName),
                        onChanged: (_) async {
                          await InhLNotifier.of(context)
                              .updateLocalization(e.key);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        title: Row(
                          children: [
                            Text(
                              '${e.value.entries.first.value} ',
                              style: const TextStyle(fontSize: 24),
                            ),
                            Text(
                              '(${e.key})',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
