import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collapsible/collapsible.dart';
import 'package:kabir_apc/ds_widgets/abstract_slate.dart';
import 'package:kabir_apc/ds_widgets/own_comment_slate.dart';
import 'package:kabir_apc/widgets/layers_stack.dart';

import 'package:simple_html_css/simple_html_css.dart';
import 'package:sem_form_core/sem_form_core.dart';
import '../comments_stack.dart';
import '../ds/entry.dart';
import '../globals.dart';
import '../up_down_button.dart';
import '../widgets/tools_subgroup.dart';
import 'entry_comments.dart';

class EntrySlate extends StatelessWidget {
  final KabEntry entry;

  const EntrySlate({
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return CommentsStackWidget(
      axis: CollapsibleAxis.vertical,
      initiallyCollapsed: false,
      collapsedChild:
      AbstractSlate(entry, includeSummary: true),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AbstractSlate(entry),
            OwnCommentSlate(entry: entry, user: currentUser),

            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: EntryComments(entry),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 2, bottom: 4),
              child: Divider(color: Color(0xAA337ACB), height: 5, thickness: 3),
            ),
          ]),
    );
  }
}
