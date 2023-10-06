import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabir_apc/ds/user.dart';


import '../ds/entry.dart';
import 'entry_slate.dart';


class EntryList extends StatefulWidget {

  final List<KabUser> users;
  final List<KabEntry> entries;
  final String currentFilter;
  final List<String> filterTargets;

  const EntryList({
    super.key,
    this.currentFilter = '',
    this.filterTargets = const [],
    this.users = const [],
    this.entries = const [],
  });


  @override
  State<EntryList> createState() => EntryListState();
}

class EntryListState extends State<EntryList> {
  buildControlItem(BuildContext context, int control) {
    return Card(child: Text('Item: $control'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      ...widget.entries.where((e) => ((widget.filterTargets.isEmpty || widget.filterTargets.contains('abstract')) && e.text.toLowerCase().contains(widget.currentFilter.toLowerCase())) ||
          ((widget.filterTargets.isEmpty || widget.filterTargets.contains('title')) && e.title.toLowerCase().contains(widget.currentFilter.toLowerCase()))).map((e) => EntrySlate(entry: e)),
    ]);
  }

}
