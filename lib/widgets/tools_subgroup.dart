import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';

class ToolsSubgroup extends StatefulWidget {
  final Widget? child;
  final bool emptySubgroup;
  const ToolsSubgroup({super.key, this.child, this.emptySubgroup = false, this.subgroupTitle = ''});

  final String subgroupTitle;

  @override
  State<ToolsSubgroup> createState() => ToolsSubgroupState();
}

class ToolsSubgroupState extends State<ToolsSubgroup> {
  bool expandControls = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final directionality = Directionality.maybeOf(context) ?? TextDirection.ltr;
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children:[
      GestureDetector(
        onTap: () => setState(() => expandControls = !expandControls),
        onLongPress: () => setState(() => expandControls = !expandControls), //ToDo: filter
        child: Text(
          '${(!expandControls ? directionality == TextDirection.rtl ? '⮜' : '⮞' : !widget.emptySubgroup ? '⮟' : '⮛')}${widget.subgroupTitle}',
          style: theme.textTheme.labelMedium,
        ),
      ),
    if (widget.child != null)
    Collapsible(
    axis: CollapsibleAxis.vertical,
    collapsed: !expandControls,
    alignment: AlignmentDirectional.topStart,
    child: widget.child!,
    ),]);
  }
}
