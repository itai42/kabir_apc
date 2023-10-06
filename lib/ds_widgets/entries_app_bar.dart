import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../ds/entry.dart';

class EntriesAppBar extends StatelessWidget {
  final List<KabEntry> entries;
  const EntriesAppBar(this.entries, {super.key});

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    // final theme = Theme.of(context);
    return
      SliverAppBar(
        shadowColor: Colors.transparent,
        toolbarHeight: 34,
        elevation: 0,
        pinned: true,
        primary: true,
        floating: true,
        backgroundColor: const Color(0xFFF3F3F3),
        actions: [
          GestureDetector(
            onSecondaryTap: () {
              messenger.showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white.withOpacity(0.5),
                  content: const Text(
                    style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                    '+ secondaryPressed',
                  ),
                ),
              );
              // TriggerOperation.loadScript(ref, testScript);
            },
            onLongPress: () {
              messenger.showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white.withOpacity(0.5),
                  content: const Text(
                    style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                    '+ longPressed',
                  ),
                ),
              );
              // TriggerOperation.loadScript(ref, testScript);
            },
            child: IconButton(
              iconSize: 22,
              splashRadius: 12,
              padding: const EdgeInsets.all(2),
              icon: const Icon(Icons.add_circle, color: Colors.teal),
              tooltip: 'Add element',
              onPressed: () {
                messenger.showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.white.withOpacity(0.5),
                    content: const Text(
                      style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                      '+ Pressed',
                    ),
                  ),
                );
                // TriggerOperation.loadScript(ref, testScript);
              },
            ),
          ),
        ],
        expandedHeight: 60,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsetsDirectional.fromSTEB(8, 1, 0, 5),
          title: FittedBox(
            fit: BoxFit.none,
            child: RichText(
              softWrap: true,
              text: HTML.toTextSpan(
                context, 'Section <U>title</U> - instructions and description goes here...',
                // 'Panel Title ${ctlDownState ? '^' : ''}${altDownState ? 'Alt ' : ''}${shiftDownState ? 'Shift ' : ''}',
                // 'Simulation script history<br/><span style="color:green">${scriptRunDuration.value?.format() ?? ScriptClockState.noDurationString}</span>',
                // "<div>Simulation script history<br/><font size=-1>SimulationTime:${scriptRunDuration.value?.format() ?? ScriptClockState.noDurationString}</font></div>",
                linksCallback: (p0) {},
                overrideStyle: {
                  'li': const TextStyle(fontSize: 14, color: Colors.black),
                },
                defaultTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ),
      );
  }
}