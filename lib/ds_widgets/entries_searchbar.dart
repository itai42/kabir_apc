import 'package:flutter/material.dart';
import 'package:sem_form_core/sem_form_core.dart';

typedef FilterChanged<T, U> = void Function(T filter, U target);

class EntriesSearchBar extends StatefulWidget {
  final String initialFilter;
  final List<String> initialTargets;
  final List<MapEntry<String,String>> availableTargets;

  /// Invoked upon user input.
  final FilterChanged<String?, List<String>?>? onChanged;

  const EntriesSearchBar({super.key, required this.availableTargets, this.initialFilter = '', this.initialTargets = const [], this.onChanged});

  @override
  State<EntriesSearchBar> createState() => EntriesSearchBarState();
}

class EntriesSearchBarState extends State<EntriesSearchBar> {
  late String currentFilter;
  late List<String> currentTargets;

  @override
  void initState() {
    currentFilter = widget.initialFilter;
    currentTargets = widget.initialTargets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        hintStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.grey)),
        onChanged: (value) {
          currentFilter = value;
          if (widget.onChanged != null) {
            widget.onChanged!(currentFilter, currentTargets);
          }
        },
        hintText: '${currentTargets.isEmpty ? ' Search ' : ' Search: '}${currentTargets.join(', ')}',
        leading: Text('Search: '),
        trailing: [
          MenuBar(
            children: [
              SubmenuButton(
                menuChildren: [
                  for (final item in widget.availableTargets)
                  DropdownMenuItem(
                      value: item,
                      child: CheckboxMenuButton(
                          closeOnActivate: false,
                          value: currentTargets.contains(item.value),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                currentTargets.addUnique(item.value);
                              } else {
                                currentTargets.remove(item.value);
                              }
                              if (widget.onChanged != null) {
                                widget.onChanged!(currentFilter, currentTargets);
                              }
                            });
                          },
                          child: Text(item.key))),
                ],
                child: Row(children: [
                  const Icon(Icons.arrow_drop_down),
                  Text('${currentTargets.isEmpty ? ' Filter ' : ' Filter: '}${currentTargets.join(', ')}'),
                ]),
              )
            ],
          ),
          const SizedBox(width: 5),
        ]);
  }
}
