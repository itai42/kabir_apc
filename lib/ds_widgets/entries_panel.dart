import 'package:flutter/material.dart';
import 'package:sem_form_core/sem_form_core.dart';
import '../base_widgets/kui_defaults.dart';
import '../ds_widgets/entries_searchbar.dart';
import '../ds_widgets/entry_list.dart';
import '../globals.dart';
import '../main.dart';
import 'chat_bar.dart';
import 'entries_app_bar.dart';
import 'package:langchain/langchain.dart';

class EntriesPanel extends StatefulWidget {
  const EntriesPanel({super.key});

  @override
  State<EntriesPanel> createState() => _EntriesPanelState();
}

class _EntriesPanelState extends State<EntriesPanel> {
  String currentFilter = '';
  List<String> currentTargets = ['title', 'abstract'];

  void setFilter(String filter, List<String> targets) {
    setState(() {
      currentFilter = filter;
      currentTargets = targets;
    });
  }

  void chat(BuildContext context, String prompt, List<String> options) {
    Future<ChatMessage> returnMessageFuture = llm([ChatMessage.human(prompt)]);
    returnMessageFuture.then((value) => setState(() => responseText = 'Q (${submitTime?.format()}): $prompt\nA (${DateTime.now().format()}): ${value.content}'), onError: (msg) =>
        setState(() =>
        responseText = 'Error: $msg'));
  }

  String responseText = '...';
  DateTime? submitTime;
  @override
  Widget build(BuildContext context) {
    return TransparentCard(
      child: CustomScrollView(
        // primary: true,
        slivers: [
          EntriesAppBar(entries),
          ChatBar(
            initialPrompt: 'write a short poem about the sun and some flowers',
            onSubmitted: (prompt, options) {
              submitTime = DateTime.now();
              if (prompt?.isNotEmpty ?? false) {
                chat(context, prompt!, options ?? const []);
              }
            },
          ).sliverBox,
          Row(children: [
            Card(child: Text(responseText)),
          ]).sliverBox,
          EntriesSearchBar(
            availableTargets: const [
              MapEntry('abstract', 'abstract'),
              MapEntry('title', 'title'),
              MapEntry('body (warning - may take more time to complete search)', 'body'),
            ],
            initialFilter: currentFilter,
            initialTargets: currentTargets,
            // onChanged: (filter, targets) => setFilter(filter ?? currentFilter, targets ?? currentTargets),
          ).sliverBox,
          EntryList(
            entries: entries,
            users: users,
            currentFilter: currentFilter,
            filterTargets: currentTargets,
          ).sliverBox,
        ],
      ),
    );
  }
}
