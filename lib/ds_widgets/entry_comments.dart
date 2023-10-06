import 'package:flutter/material.dart';

import '../ds/entry.dart';
import 'comment_list.dart';

class EntryComments extends StatelessWidget {
  final KabEntry entry;

  KabEntry get e => entry;

  const EntryComments(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Flexible(
        flex: 1,
        child: CommentList(e.proComments, title: 'Pro comments:'),
      ),
      Flexible(
        flex: 1,
        child: CommentList(e.conComments, title: 'Con comments:'),
      ),
    ]);
  }
}
