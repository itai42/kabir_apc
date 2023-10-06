import 'package:flutter/material.dart';
import 'package:sem_form_core/sem_form_core.dart';

typedef FilterChanged<T, U> = void Function(T filter, U target);

class ChatBar extends StatefulWidget {
  final String initialPrompt;
  final String initialFilter;
  final List<String> initialOptions;
  final List<MapEntry<String,String>> availableOptions;

  /// Invoked upon user input.
  final FilterChanged<String?, List<String>?>? onChanged;
  final FilterChanged<String?, List<String>?>? onSubmitted;

  const ChatBar({super.key, this.initialPrompt = '', this.initialFilter = '', this.initialOptions = const [], this.availableOptions = const [], this.onChanged, this.onSubmitted});

  @override
  State<ChatBar> createState() => ChatBarState();
}

class ChatBarState extends State<ChatBar> {
  late String currentPrompt;
  late List<String> currentOptions;
  late TextEditingController controller;
  @override
  void initState() {
    currentPrompt = widget.initialFilter;
    currentOptions = widget.initialOptions;
    controller = TextEditingController(text: widget.initialPrompt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(controller: controller,
        hintStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.grey)),
        onChanged: (value) {
          currentPrompt = value;
          if (widget.onChanged != null) {
            widget.onChanged!(currentPrompt, currentOptions);
          }
        },
        onSubmitted: (value) {
          currentPrompt = value;
          if (widget.onSubmitted != null) {
            widget.onSubmitted!(currentPrompt, currentOptions);
          }
        },
        hintText: '${currentOptions.isEmpty ? ' enter prompt ' : ' enter prompt ('}${currentOptions.join(', ')}',
        leading: const Text('Prompt: '),
        trailing: [
          MenuBar(
            children: [
              SubmenuButton(
                menuChildren: [
                  for (final item in widget.availableOptions)
                    DropdownMenuItem(
                        value: item,
                        child: CheckboxMenuButton(
                            closeOnActivate: false,
                            value: currentOptions.contains(item.value),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  currentOptions.addUnique(item.value);
                                } else {
                                  currentOptions.remove(item.value);
                                }
                                if (widget.onChanged != null) {
                                  widget.onChanged!(currentPrompt, currentOptions);
                                }
                              });
                            },
                            child: Text(item.key))),
                ],
                child: Row(children: [
                  const Icon(Icons.arrow_drop_down),
                  Text('${currentOptions.isEmpty ? ' Filter ' : ' Filter: '}${currentOptions.join(', ')}'),
                ]),
              )
            ],
          ),
          const SizedBox(width: 5),
        ]);
  }
}
