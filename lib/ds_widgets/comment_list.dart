import 'package:flutter/material.dart';

import '../ds/comment.dart';
import 'comment_slate.dart';

class CommentList extends StatelessWidget {
  final List<KabComment> comments;
  final String? title;
  const CommentList(this.comments, {this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (title != null) Text(title!, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      for (int i = 0; i < comments.length; i++)
        Column(children: [
          Divider(
              color: Color.lerp(const Color(0xaaFFE99E), const Color(0xaaFFA100), (i / (comments.isEmpty ? 1 : comments.length))),
              height: 2,
              thickness: 1,
              indent: 25,
              endIndent: 25),
          CommentSlate(comments[i]),
        ]),
    ]);
  }
}
