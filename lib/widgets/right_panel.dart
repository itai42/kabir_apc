import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:sem_form_core/extensions/core_extensions.dart';
import 'package:sem_form_core/extensions/foundation_classes.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'tools_stack.dart';
import '../globals.dart';
import '../utils/known_constants.dart';
import 'badged_icon_button.dart';
import 'info_widgets.dart';


import 'layers_stack.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({super.key});

  @override
  State<RightPanel> createState() => RightPanelState();
}

class RightPanelState extends State<RightPanel> {

  void shiftListener() =>
      setState(() {
        shiftDownState = isShiftDown.value;
      });
  void ctlListener() =>
      setState(() {
        ctlDownState = isCtlDown.value;
      });

  @override
  void initState() {
    super.initState();

    isShiftDown.addListener(shiftListener);
    isCtlDown.addListener(ctlListener);
    // isAltDown.addListener(() => setState(() {
    //   altDownState = isAltDown.value;
    // }));
  }

  @override
  void dispose() {
    isShiftDown.removeListener(shiftListener);
    isCtlDown.removeListener(ctlListener);
    super.dispose();
  }

  bool showDocsSettings = const bool.fromEnvironment('showDocsSettings', defaultValue: false);
  bool shiftDownState = false;
  bool altDownState = false;
  bool ctlDownState = false;

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    return Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.zero,
      color: const Color(0xFFFFFEF6),
      child:
      // Directionality(
      //   textDirection: TextDirection.rtl,
      //   child:
        CustomScrollView(slivers: [
          SliverAppBar(
            shadowColor: Colors.transparent,
            toolbarHeight: 34,
            elevation: 0,
            pinned: true,
            primary: true,
            floating: true,
            backgroundColor: const Color(0xFFF3F3F3),
            actions: [
              IconButton(
                iconSize: 22,
                splashRadius: 12,
                padding: const EdgeInsets.all(2),
                icon: const Icon(Icons.add_circle, color: Colors.teal),
                tooltip: 'Add element',
                onPressed: () {
                  // TriggerOperation.loadScript(ref, testScript);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.fromSTEB(8, 1, 0, 5),
              title: FittedBox(
                fit: BoxFit.fitHeight,
                child: RichText(
                  softWrap: true,
                  text: HTML.toTextSpan(
                    context,
                    'Panel Title ${ctlDownState ? '^' : ''}${altDownState ? 'Alt ' : ''}${shiftDownState ? 'Shift ' : ''}',
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
          LayerStackWidget(
            axis: CollapsibleAxis.vertical,
            onLongPress: () => setState(() => showDocsSettings = !showDocsSettings),
            expandedIcon: BadgedIconButton(
              badgeAngleBounds: StrictBounds(start: 60.deg, end: 180.deg),
              placeInCard: true,
              color: Colors.black12,
              borderColor: Colors.black12,
              borderWidth: 0,
              badgeRadialTranslation: const Offset(-9, 0),
              // size: Size(28,28),
              // badges: badges,
              badgeSize: const Size(16, 16),
              children: const [Padding(padding: EdgeInsets.all(4), child: FittedBox(fit: BoxFit.contain, child: Icon(KnownIcons.dash, color: Colors.white)))],
            ),
            collapsedIcon: BadgedIconButton(
              badgeAngleBounds: StrictBounds(start: 60.deg, end: 180.deg),
              keepBadgeEdgeMargin: true,
              placeInCard: true,
              color: Colors.black12,
              borderColor: Colors.black12,
              borderWidth: 0,
              badgeRadialTranslation: const Offset(-11, 0),
              badgeSize: const Size(16, 16),
              children: const [Padding(padding: EdgeInsets.all(4), child: FittedBox(fit: BoxFit.contain, child: Icon(Icons.add, color: Colors.white)))],
            ),
            expandedIconSize: 24,
            collapsedIconSize: 24,
            expandedIconSplashSize: 24,
            sizingBuilder: (context, {required child, required layerStackWidget}) => child,
            collapsedIconSplashSize: 24,
            initiallyCollapsed: false,
            collapsedChild: Row(children: [
              Text(
                'מחלקה:',
                // '<a href="toggle">מתמחים:</a>',
                // linksCallback: (p0) {
                //   if (p0 == 'toggle') {
                //
                //     setState(() {
                //       docsFilterStatus.value.toggleAllNoneLast();
                //     });
                //     docsFilterStatus.markDirty();
                // }
                // },
                style: theme.textTheme.labelSmall,
                // overrideStyle: {'a': SfDocTheme.defaultDocLinkTextStyle},
                // style: SfDocTheme.docListTitleTextStyle,
                // ),
              )
            ]),
            child: Column(children: [
              if (showDocsSettings)
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 0,
                      // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                      shadowColor: Colors.transparent,
                      color: Colors.grey.withAlpha(50),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                        child: Text('A'),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Card(
                      elevation: 0,
                      // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                      shadowColor: Colors.transparent,
                      color: Colors.grey.withAlpha(50),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                        child: Text('B'),
                      ),
                    ),
                  ),
                  // )),
                ]),

              if (showDocsSettings)
                Row(children: [
                  DropdownButton(
                    // selectedItemBuilder: (context) => [0.1, 0.5, 1, 2, 3, 4, 5, 10, 30, 60, 120, 600, 3600]
                    //     .map((val) => Center(child: RoundTextBadge(text: 'x${val.toStringAsPrecision(2)}', padding: EdgeInsets.all(8), hasBloom: false, fontSize: 12)))
                    //     .toListNG(),
                      elevation: 0,
                      underline: Container(),
                      iconSize: 0,
                      alignment: Alignment.center,
                      isDense: false,
                      items: [0.1, 0.5, 1, 2, 3, 4, 5, 10, 30, 60, 120, 600, 3600]
                          .map((val) =>
                          DropdownMenuItem(
                              value: val,
                              child: Center(
                                  child: RoundTextBadge(
                                      color: Colors.white.withLightness(0.7).withAlpha(val == 1 ? 150 : 50),
                                      bloomColor: Colors.transparent,
                                      borderColor: Colors.black12,
                                      borderWidth: 1,
                                      text: 'x${(val >= 3600) ? '${(val / 3600).toString()}h' : val > 60 ? '${(val / 60).toString()}m' : val.toString()}',
                                      padding: const EdgeInsets.all(14),
                                      hasBloom: false,
                                      fontSize: 12))))
                          .toListNG(),
                      value: 1,
                      onChanged: (value) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: 'Value changed to: $value',
                            builder: (context) {
                              return AlertDialog(
                                icon: Row(children: const [Icon(Icons.notification_important_outlined)]),
                                title: Row(children: [const Icon(Icons.notification_important_outlined), Text('Value: $value')]),
                                actions: [
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text('Yes')),
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text('No'))
                                ],
                              );
                            });
                      })
                ]),
              // ResourceJsonTree(jsonDecode(fhirModifiers)),
              const ToolsStack(),
            ]),
          ).sliverBox,
        ]),
      // ),
    );
  }
}
