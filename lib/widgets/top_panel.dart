import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kabir_apc/comments_stack.dart';
import 'package:sem_form_core/sem_form_core.dart';
import '../globals.dart';
import '../up_down_vote.dart';
import '../utils/extensions.dart';
import 'package:simple_html_css/simple_html_css.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({super.key});

  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  static double get r => 4;

  // List<Widget> children = [svg];(top: 100, left: 200, child:SizedBox(width: 120, height: 100, child: ,))];

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    return Card(
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      child: CustomScrollView(slivers: [
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
            collapseMode: CollapseMode.parallax,
            stretchModes: [StretchMode.blurBackground],
            centerTitle: false,
            titlePadding: const EdgeInsetsDirectional.fromSTEB(8, 1, 0, 5),
            title: FittedBox(
              fit: BoxFit.fitHeight,
              child: RichText(
                softWrap: true,
                text: HTML.toTextSpan(
                  context, 'Section title - instructions and description goes here...',
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
        ),
        VotingWidget.upDown(entries: entries, users: users).sliverBox,
        // CommentsStackWidget(child: Text("asd")).sliverBox,
      ]),
    );
  }
}
