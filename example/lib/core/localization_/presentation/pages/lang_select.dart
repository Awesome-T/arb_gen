import 'package:example/core/localization_/presentation/notifier.dart';
import 'package:example/localization/localization.g.dart';
import 'package:flutter/material.dart';

///
///
class LangSelect extends StatefulWidget {
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
          final _entries = _notifier.value.entries.where(
              (entry) => entry.key.contains(_textEditingController.text));
          var _feached = Map.fromEntries(_entries);
          _notifier.value = _feached;
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
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    maxLength: 20,
                    scrollPadding: EdgeInsets.all(2),
                    decoration: InputDecoration(
                      helperMaxLines: 1,
                      suffix: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _textEditingController.clear(),
                      ),
                      prefix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => _textEditingController.clear(),
                      ),
                      border: UnderlineInputBorder(),
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
                        groupValue:
                            Locale(AppLocalezation.of(context).localeName),
                        onChanged: (_) async {
                          InhLNotifier.of(context).updateLocalization(e.key);
                          Navigator.of(context).pop();
                        },
                        title: Row(
                          children: [
                            Text(
                              '${e.value.entries.first.value} ',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              '(${e.key})',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
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
