import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:kabir_apc/ds/entry.dart';
import 'package:kabir_apc/ds/user.dart';

import '../comments_stack.dart';
import '../up_down_button.dart';

class OwnCommentSlate extends StatelessWidget {
  final KabEntry entry;
  final KabUser user;
  const OwnCommentSlate({required this.user, required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
      CommentsStackWidget(
        initiallyCollapsed: true,
        collapsedIcon: const SizedBox(),
        expandedIcon: const Icon(Icons.close),
        collapsedChild: Row(children: [
          Text(
            entry.hasCommentsBy(user) ? 'View and edit your comment' : 'Write your own comment',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: Colors.indigo, decoration: TextDecoration.underline, fontWeight: entry.hasCommentsBy(user) ? FontWeight.bold : FontWeight.normal),
          )
        ]),
        axis: CollapsibleAxis.vertical,
        cardColor: Colors.lightGreenAccent.withOpacity(0.3),
        alignment: AlignmentDirectional.topStart,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
          Flexible(
            flex: 1,
            child: Card(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(6, 8, 6, 0),
                  child: TextFormField(
                    initialValue: entry.proComments.where((c) => c.byUser == user).lastOrNull?.title ?? '',
                    // controller: TextEditingController(),
                    // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',

                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true, hintText: 'write the title for your pro comment', fillColor: Colors.black12, filled: true, labelText: "Pro title"),
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(6, 0, 6, 8),
                  child: TextFormField(
                    initialValue: entry.proComments.where((c) => c.byUser == user).lastOrNull?.comment ?? '',
                    // controller: TextEditingController(),
                    // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',

                    readOnly: false,
                    maxLines: 900,
                    minLines: 1,
                    decoration: const InputDecoration(isDense: true, hintText: 'write your pro comment', fillColor: Colors.white10, filled: true, labelText: "Pro body"),
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
          Flexible(
            flex: 1,
            child: Card(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(6, 8, 6, 0),
                  child: TextFormField(
                    initialValue: entry.conComments.where((c) => c.byUser == user).lastOrNull?.title ?? '',
                    // controller: TextEditingController(),
                    // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',

                    readOnly: false,
                    decoration: const InputDecoration(
                        isDense: true, hintText: 'write the title for your con comment', fillColor: Colors.black12, filled: true, labelText: "Con title"),
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(6, 0, 6, 8),
                  child: TextFormField(
                    initialValue: entry.conComments.where((c) => c.byUser == user).lastOrNull?.comment ?? '',
                    // controller: TextEditingController(),
                    // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',

                    readOnly: false,
                    maxLines: 900,
                    minLines: 1,
                    decoration: const InputDecoration(isDense: true, hintText: 'write your con comment', fillColor: Colors.white10, filled: true, labelText: "Con body"),

                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      );
  }
}
