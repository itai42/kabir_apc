import 'package:flutter/material.dart';

import '../ds/comment.dart';
import '../ds/entry.dart';
import '../up_down_button.dart';
import '../widgets/tools_subgroup.dart';

class CommentSlate extends StatelessWidget {
  final KabComment comment;
  const CommentSlate(this.comment,{super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const UpDownButton(buttonsAxis: Axis.vertical, iconSize: 16),
      Card(
        child: ToolsSubgroup(
          // emptySubgroup: wardStackControls.isEmpty,
          subgroupTitle: comment.title,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
            child: Text(comment.comment, style: theme.textTheme.labelMedium),
          ),
        ),
      ),
    ]);
  }
}
