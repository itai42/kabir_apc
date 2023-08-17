import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'tools_subgroup.dart';

class ToolsStack extends StatefulWidget {
  const ToolsStack({super.key});

  @override
  State<ToolsStack> createState() => ToolsStackState();
}

class ToolsStackState extends State<ToolsStack> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<int> wardStackControls = [1, 2, 3, 5];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('Main Title', style: theme.textTheme.titleMedium),
      const Divider(color: Color(0xFFFFE99E), height: 2, thickness: 2),
      ToolsSubgroup(
          emptySubgroup: wardStackControls.isEmpty,
          subgroupTitle: 'Subgroup Title:',
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
            child: Wrap(
              runSpacing: 2,
              spacing: 2,
              children: [
                ...wardStackControls.map((control) => buildControlItem(context, control)), //ToDo: filter
              ],
            ),
          )),
      const Divider(color: Color(0xFFFFE280), height: 2, thickness: 2),
      ToolsSubgroup(
        emptySubgroup: wardStackControls.isEmpty,
        subgroupTitle: 'Subgroup Title:',
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
          child: Text('SubGroup', style: theme.textTheme.labelMedium),
        ),
      ),
      const Divider(color: Color(0xFFFFD038), height: 2, thickness: 2),
      ToolsSubgroup(
        emptySubgroup: wardStackControls.isEmpty,
        subgroupTitle: 'Subgroup Title:',
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
          child: Text('SubGroup', style: theme.textTheme.labelMedium),
        ),
      ),
      const Divider(color: Color(0xFFFFC600), height: 2, thickness: 2),
      ToolsSubgroup(
        emptySubgroup: wardStackControls.isEmpty,
        subgroupTitle: 'Subgroup Title:',
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
          child: Text('SubGroup', style: theme.textTheme.labelMedium),
        ),
      ),
      const Divider(color: Color(0xFFFFB330), height: 2, thickness: 2),
      ToolsSubgroup(
        emptySubgroup: wardStackControls.isEmpty,
        subgroupTitle: 'Subgroup Title:',
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
          child: Text('SubGroup', style: theme.textTheme.labelMedium),
        ),
      ),
      const Divider(color: Color(0xFFFFB330), height: 2, thickness: 2),
      ToolsSubgroup(
        emptySubgroup: wardStackControls.isEmpty,
        subgroupTitle: 'Subgroup Title:',
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
          child: Text('SubGroup', style: theme.textTheme.labelMedium),
        ),
      ),
      const Divider(color: Color(0xFFFFA100), height: 2, thickness: 2),
      ToolsSubgroup(
        emptySubgroup: wardStackControls.isEmpty,
        subgroupTitle: 'Subgroup Title:',
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
          child: Text('SubGroup', style: theme.textTheme.labelMedium),
        ),
      ),
    ]);
  }

  buildControlItem(BuildContext context, int control) {
    return Card(child: Text('Item: $control'));
  }
}

// import 'history_slate.dart';
// import 'log_slate.dart';
//
// class DocsStack extends StatefulWidget {
//   final String scriptName;
//
//   const DocsStack({super.key, required this.scriptName});
//
//   @override
//   State<StatefulWidget> createState() => DocStackState();
// }
//
// class DocStackState extends State<DocsStack> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   bool get hasDocs => docInstances.isNotEmpty;
//   String notepadText = '';
//   bool expandControls = const bool.fromEnvironment('expandControls', defaultValue: true);
//   bool expandNotepad = const bool.fromEnvironment('expandNotepad', defaultValue: true);
//   bool expandLog = const bool.fromEnvironment('expandLog', defaultValue: true);
//   bool expandHistory = const bool.fromEnvironment('expandHistory', defaultValue: true);
//
//   @override
//   Widget build(BuildContext context) {
//     // List<ControlInfo> wardStackControls = [
//     //   ControlInfo(
//     //       text: 'התחל',
//     //       action: RunAction(),
//     //       intent: RunIntent(
//     //           stepLimit: Settings.stepLimit, cal: calInstance, month: calInstance.instance.getMonth(ref.watch(activeMonthProvider).value))),
//     //   ControlInfo(
//     //       text: 'עצור',
//     //       action: StopAction(),
//     //       intent: StopIntent(cal: calInstance, month: calInstance.instance.getMonth(activeMonth.value))),
//     //   ControlInfo(
//     //       text: 'אפס חודש',
//     //       action: ResetAction(),
//     //       intent: ResetIntent(cal: calInstance, month: calInstance.instance.getMonth(activeMonth.value), resetTarget: ResetTarget.month)),
//     //   ControlInfo(
//     //       text: 'אפס הכל',
//     //       action: ResetAction(),
//     //       intent: ResetIntent(cal: calInstance, month: calInstance.instance.getMonth(activeMonth.value), resetTarget: ResetTarget.cal)),
//     // ];
//
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Text(widget.scriptName),
//       const Divider(color: Color(0xFFFFE99E), height: 2, thickness: 3),
//       GestureDetector(
//         onTap: () => setState(() => expandControls = !expandControls),
//         onLongPress: () => setState(() => expandControls = !expandControls), //ToDo: filter
//         child: Text(
//           '${(!expandControls ? '⮜' : wardStackControls.isNotEmpty ? '⮟' : '⮛')}לוח בקרה:',
//           style: SfDocTheme.docListTitleTextStyle,
//         ),
//       ),
//       Collapsible(
//         axis: CollapsibleAxis.vertical,
//         collapsed: !expandControls,
//         alignment: AlignmentDirectional.topStart,
//         child: Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
//           child: Wrap(
//             runSpacing: 2,
//             spacing: 2,
//             children: [
//               ...wardStackControls.map((control) => buildControlItem(context, control)), //ToDo: filter
//             ],
//           ),
//         ),
//       ),
//       const Divider(color: Color(0xFFFFE280), height: 2, thickness: 2),
//       const Divider(color: Color(0xFFFFD038), height: 2, thickness: 2),
//       GestureDetector(
//         onTap: () => setState(() => expandHistory = !expandHistory),
//         onLongPress: () => setState(() => expandHistory = !expandHistory), //ToDo: filter
//         child: Text(
//           '${(!expandHistory ? '⮜' : historyTree.isNotEmpty ? '⮟' : '⮛')}History: ',
//           style: SfDocTheme.docListTitleTextStyle,
//         ),
//       ),
//       Column(children: [
//         Collapsible(
//           axis: CollapsibleAxis.vertical,
//           collapsed: !expandHistory,
//           alignment: AlignmentDirectional.topStart,
//           child: Padding(
//             padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
//             child: Directionality(textDirection: TextDirection.ltr, child: HistorySlate(historyTree: historyTree)),
//           ),
//         ),
//       ]),
//       const Divider(color: Color(0xFFFFC600), height: 1, thickness: 1),
//       GestureDetector(
//         onTap: () => setState(() => filterStatus.toggleAllNoneLast()),
//         onLongPress: () => setState(() => filterStatus.toggleAllNoneLast()), //ToDo: filter
//         child: Text(
//           '${hasDocs ? (filterStatus.isNone ? '⮜' : filterStatus.isAll ? '⮟' : '⮛') : ''}מתמחים:',
//           style: SfDocTheme.docListTitleTextStyle,
//         ),
//       ),
//       Collapsible(
//         axis: CollapsibleAxis.vertical,
//         collapsed: filterStatus.isNone,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ...docInstances.map((doc) => buildDocItem(context, doc)), //ToDo: filter
//           ],
//         ),
//       ),
//       const Divider(color: Color(0xFFFFB330), height: 1, thickness: 1),
//       GestureDetector(
//         onTap: () => setState(() => expandLog = !expandLog),
//         onLongPress: () => setState(() => expandLog = !expandLog), //ToDo: filter
//         child: Text(
//           '${(!expandLog ? '⮜' : logInfo.logEntries.isNotEmpty ? '⮟' : '⮛')}Log: ',
//           style: SfDocTheme.docListTitleTextStyle,
//         ),
//       ),
//       Column(children: [
//         Collapsible(
//           axis: CollapsibleAxis.vertical,
//           collapsed: !expandLog,
//           alignment: AlignmentDirectional.topStart,
//           child: Padding(
//             padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
//             child: Directionality(textDirection: TextDirection.ltr, child: LogSlate(logInfo: logInfo)),
//           ),
//         ),
//       ]),
//       const Divider(color: Color(0xFFFFB330), height: 1, thickness: 1),
//       GestureDetector(
//         onTap: () => setState(() => expandNotepad = !expandNotepad),
//         onLongPress: () => setState(() => expandNotepad = !expandNotepad), //ToDo: filter
//         child: Text(
//           '${(!expandNotepad ? '⮜' : notepadText.isNotEmpty ? '⮟' : '⮛')}Notepad:',
//           style: SfDocTheme.docListTitleTextStyle,
//         ),
//       ),
//       Collapsible(
//         axis: CollapsibleAxis.vertical,
//         collapsed: !expandNotepad,
//         alignment: AlignmentDirectional.topStart,
//         child: Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(2, 1, 0, 4),
//           child: TextField(
//               onChanged: (value) => notepadText = value,
//               textDirection: TextDirection.rtl,
//               cursorColor: Colors.black,
//               enabled: true,
//               style: SfDocTheme.docListTitleTextStyle.copyWith(color: Colors.black),
//               maxLines: 20,
//               minLines: 1,
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                       borderSide:
//                       BorderSide(style: BorderStyle.solid, color: Colors.black, strokeAlign: BorderSide.strokeAlignCenter, width: 1)))),
//         ),
//       ),
//       const SizedBox(height: 2),
//       const Divider(color: Color(0xFFFFA100), height: 2, thickness: 2),
//
//       // const SizedBox(height: 2),
//     ]);
//   }
//
//   Widget buildScriptNodeItem(BuildContext context, dynamic scriptNode) {
//     return Text(scriptNode.toString());
//   }
//
//   Widget buildDocItem(BuildContext context, DocInstance doc) =>
//       Padding(padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2), child: DocMenuSlate(doc));
//
//   Widget buildControlItem(BuildContext context, ControlInfo controlInfo) {
//     return ActionChip(
//       label: Text(controlInfo.text),
//       onPressed: () {
//         Actions.invoke(context, controlInfo.intent);
//       },
//       elevation: 1,
//     );
//   }
// }
