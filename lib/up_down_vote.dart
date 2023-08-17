import 'package:collapsible/collapsible.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabir_apc/ds/user.dart';
import 'package:kabir_apc/widgets/layers_stack.dart';

import 'package:sem_form_core/sem_form_core.dart';
import 'comments_stack.dart';
import 'ds/entry.dart';
import 'globals.dart';
import 'up_down_button.dart';
import 'widgets/tools_subgroup.dart';

class VotingWidget extends StatefulWidget {
  final bool isUpPressedInitially;
  final bool isDownPressedInitially;
  final IconData upIconFilled;
  final IconData downIconFilled;
  final IconData upIconOutlined;
  final IconData downIconOutlined;
  final Axis childAxis;
  final Axis commentAxis;
  final Axis buttonsAxis;
  final bool hideNonSelected;
  final bool allowCommentEntry;
  final Widget? child;
  final String? upComment;
  final String? downComment;
  final String? unselectedComment;
  final bool clickable;
  final List<KabUser> users;
  final List<KabEntry> entries;

  const VotingWidget({
    super.key,
    this.isUpPressedInitially = false,
    this.upIconFilled = Icons.thumb_up,
    this.downIconFilled = Icons.thumb_down,
    this.upIconOutlined = Icons.thumb_up_outlined,
    this.downIconOutlined = Icons.thumb_down_outlined,
    this.isDownPressedInitially = false,
    this.childAxis = Axis.horizontal,
    this.commentAxis = Axis.horizontal,
    this.buttonsAxis = Axis.horizontal,
    this.hideNonSelected = false,
    this.allowCommentEntry = false,
    this.clickable = true,
    this.upComment,
    this.downComment,
    this.unselectedComment,
    this.users = const [],
    this.entries = const [],
    this.child,
  });

  const VotingWidget.upDown({
    super.key,
    this.isUpPressedInitially = false,
    this.upIconFilled = CupertinoIcons.arrowtriangle_up_fill,
    this.downIconFilled = CupertinoIcons.arrowtriangle_down_fill,
    this.upIconOutlined = CupertinoIcons.arrowtriangle_up,
    this.downIconOutlined = CupertinoIcons.arrowtriangle_down,
    this.isDownPressedInitially = false,
    this.childAxis = Axis.horizontal,
    this.commentAxis = Axis.horizontal,
    this.buttonsAxis = Axis.vertical,
    this.hideNonSelected = true,
    this.allowCommentEntry = false,
    this.clickable = true,
    this.upComment,
    this.downComment,
    this.unselectedComment,
    this.users = const [],
    this.entries = const [],
    this.child,
  });

  const VotingWidget.plusMinus({
    super.key,
    this.isUpPressedInitially = false,
    this.upIconFilled = CupertinoIcons.plus_square_fill,
    this.downIconFilled = CupertinoIcons.minus_square_fill,
    this.upIconOutlined = CupertinoIcons.plus_square,
    this.downIconOutlined = CupertinoIcons.minus_square,
    this.isDownPressedInitially = false,
    this.childAxis = Axis.horizontal,
    this.commentAxis = Axis.horizontal,
    this.buttonsAxis = Axis.vertical,
    this.hideNonSelected = true,
    this.allowCommentEntry = false,
    this.clickable = true,
    this.upComment,
    this.downComment,
    this.unselectedComment,
    this.users = const [],
    this.entries = const [],
    this.child,
  });

  @override
  State<VotingWidget> createState() => VotingWidgetState();
}

class VotingWidgetState extends State<VotingWidget> {
  late TextEditingController editController;

  @override
  void initState() {
    editController = TextEditingController(text: comment);
    super.initState();
  }

  bool? _isUpPressed;

  bool get isUpPressed => _isUpPressed ?? widget.isUpPressedInitially;

  set isUpPressed(bool value) => _isUpPressed = value;

  IconData get upIcon => isUpPressed ? widget.upIconFilled : widget.upIconOutlined;

  bool? _isDownPressed;

  bool get isDownPressed => _isDownPressed ?? widget.isDownPressedInitially;

  set isDownPressed(bool value) => _isDownPressed = value;

  IconData get downIcon => isDownPressed ? widget.downIconFilled : widget.downIconOutlined;

  String? get comment => (!isUpPressed && !isDownPressed) ? widget.unselectedComment : ((isUpPressed ? widget.upComment : null) ?? (isDownPressed ? widget.downComment : null));

  buildControlItem(BuildContext context, int control) {
    return Card(child: Text('Item: $control'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      // Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [

      ...widget.entries.map((e) => entryWidgetOf(context, e)),
    ]);
    // );
  }

  Widget entryWidgetOf(BuildContext context, KabEntry e) {
    final theme = Theme.of(context);
    final arrowsWidget = UpDownButton(
      upIconFilled: widget.upIconFilled,
      downIconFilled: widget.downIconFilled,
      upIconOutlined: widget.upIconOutlined,
      downIconOutlined: widget.downIconOutlined,
      isUpPressed: isUpPressed,
      commentAxis: widget.commentAxis,
      isDownPressed: isDownPressed,
      clickable: widget.clickable,
      buttonsAxis: widget.buttonsAxis,
      childAxis: widget.childAxis,
      downComment: widget.downComment,
      upComment: widget.upComment,
      hideNonSelected: widget.hideNonSelected,
      unselectedComment: widget.unselectedComment,
      onUpPressed: ({required bool isUpPressed, required bool isDownPressed}) {
        setState(() {
          this.isUpPressed = !isUpPressed;
          if (this.isUpPressed) {
            this.isDownPressed = false;
          }
          // editController.text = comment ?? '';
        });
      },
      onDownPressed: ({required bool isUpPressed, required bool isDownPressed}) {
        if (!widget.clickable) {
          return;
        }
        setState(() {
          this.isDownPressed = !isDownPressed;
          if (this.isDownPressed) {
            this.isUpPressed = false;
          }
          // editController.text = comment ?? '';
        });
      },
    );
    List<int> wardStackControls = [1, 2, 3, 5];
    final textCard = Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              e.title.addPostfix(":"),
              style: theme.textTheme.titleMedium,
            ),
            TextFormField(
              initialValue: e.text,
              // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',
              minLines: 1,
              maxLines: 5,
              readOnly: true,
              decoration: const InputDecoration.collapsed(hintText: ''),
              style: theme.textTheme.bodyMedium,
            ),
          ]),
        ));
    return CommentsStackWidget(
      axis: CollapsibleAxis.both,
      initiallyCollapsed: false,
      collapsedChild: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2), child: textCard),
        const Divider(color: Color(0xAA337ACB), height: 3, thickness: 3),
      ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wrap(
            //   runSpacing: 2,
            //   spacing: 2,
            //   children: [
            //     ...wardStackControls.map((control) => buildControlItem(context, control)), //ToDo: filter
            //   ],
            // ),
            textCard,
            CommentsStackWidget(
              initiallyCollapsed: true,
              collapsedIcon: SizedBox(),
              expandedIcon: Icon(Icons.close),
              collapsedChild: Row(children: [
                Text(
                  e.hasCommentsBy(currentUser) ? 'View and edit your comment' : 'Write your own comment',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.indigo, decoration: TextDecoration.underline, fontWeight: e.hasCommentsBy(currentUser) ?FontWeight.bold:FontWeight.normal),
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
                        padding: EdgeInsetsDirectional.fromSTEB(6, 8, 6, 0),
                        child: TextFormField(
                          initialValue: e.proComments.where((c) => c.byUser == currentUser).lastOrNull?.title ?? '',
                          // controller: TextEditingController(),
                          // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',

                          readOnly: false,
                          decoration: const InputDecoration(
                              isDense: true, hintText: 'write the title for your pro comment', fillColor: Colors.black12, filled: true, labelText: "Pro title"),
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 0, 6, 8),
                        child: TextFormField(
                          initialValue: e.proComments.where((c) => c.byUser == currentUser).lastOrNull?.comment ?? '',
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
                        padding: EdgeInsetsDirectional.fromSTEB(6, 8, 6, 0),
                        child: TextFormField(
                          initialValue: e.conComments.where((c) => c.byUser == currentUser).lastOrNull?.title ?? '',
                          // controller: TextEditingController(),
                          // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',

                          readOnly: false,
                          decoration: const InputDecoration(
                              isDense: true, hintText: 'write the title for your con comment', fillColor: Colors.black12, filled: true, labelText: "Con title"),
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 0, 6, 8),
                        child: TextFormField(
                          initialValue: e.conComments.where((c) => c.byUser == currentUser).lastOrNull?.comment ?? '',
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
                // ]),
                // Text('  Rate this plan:', style: theme.textTheme.titleSmall),
                // if (widget.child != null) Flex(direction: widget.childAxis, crossAxisAlignment: CrossAxisAlignment.start, children: [arrowsWidget, widget.child!]),
                // if (widget.child == null) arrowsWidget,
              ]),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Flexible(
                  flex: 1,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Pro comments:", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    for (int i = 0; i < (e.proComments.length ?? 0); i++)
                      Column(children: [
                        Divider(
                            color: Color.lerp(const Color(0xaaFFE99E), const Color(0xaaFFA100), (i / (e.proComments.length ?? 1.0))),
                            height: 2,
                            thickness: 1,
                            indent: 25,
                            endIndent: 25),
                        Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          UpDownButton(buttonsAxis: Axis.vertical, iconSize: 16),
                          Card(
                            child: ToolsSubgroup(
                              emptySubgroup: wardStackControls.isEmpty,
                              subgroupTitle: e.proComments[i].title,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
                                child: Text(e.proComments[i].comment, style: theme.textTheme.labelMedium),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                  ]),
                ),
                Flexible(
                  flex: 1,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Con comments:", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    for (int i = 0; i < (e.conComments.length ?? 0); i++)
                      Column(children: [
                        Divider(
                            color: Color.lerp(const Color(0xaaFFE99E), const Color(0xaaFFA100), (i / (e.conComments.length ?? 1.0))),
                            height: 2,
                            thickness: 1,
                            indent: 25,
                            endIndent: 25),
                        Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          UpDownButton(buttonsAxis: Axis.vertical),
                          Card(
                            child: ToolsSubgroup(
                              emptySubgroup: wardStackControls.isEmpty,
                              subgroupTitle: e.conComments[i].title,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
                                child: Text(e.conComments[i].comment, style: theme.textTheme.labelMedium),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                  ]),
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 2, bottom: 4),
              child: Divider(color: Color(0xAA337ACB), height: 5, thickness: 3),
            ),
          ]),
    );
  }
}
