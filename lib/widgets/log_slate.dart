// import 'package:flutter/material.dart';
//
// import '../process/log.dart';
// import 'log_entry_slate.dart';
//
// class LogSlate extends StatelessWidget {
//   final LogInfo logInfo;
//
//   const LogSlate({super.key, required this.logInfo});
//
//   @override
//   Widget build(BuildContext context) {
//     if (logInfo.logEntries.isEmpty) {
//       return const SizedBox();
//     }
//     return ConstrainedBox(constraints: const BoxConstraints(maxHeight: 300),child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min,
//       children: logInfo.orderedEntries.map((e) => LogEntrySlate(logEntryInfo: e)).toList(),
//     )));
//     // return JsonTreeWidget(autoExpandLevel: 9, logInfo.asDisplayJson, headerFields: ['title'], decorationFields: ['shortText']);//, detailFields: ['longText'])
//   }
// }
