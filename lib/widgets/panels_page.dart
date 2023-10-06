import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:kabir_apc/ds_widgets/entries_panel.dart';
import 'package:sem_form_core/extensions/core_extensions.dart';
import 'package:sem_form_core/extensions/foundation_classes.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../globals.dart';
import '../up_down_vote.dart';
import 'bottom_panel.dart';
import 'info_widgets.dart';
import 'layers_stack.dart';
import 'right_panel.dart';
import 'top_panel.dart';
// import 'top_panel.dart';

// import 'package:semform/utils/extensions.dart';
// import 'package:semform/utils/sf_theme.dart';
//
// import '../globals.dart';
// import '../process/process_actions.dart';
// import 'badged_icon_button.dart';
// import 'docs_stack.dart';
// import 'info_widgets.dart';
// import 'layers_stack.dart';
// import 'month_slate.dart';
// import 'stats_filter_widget.dart';

class PanelsPage extends StatefulWidget {
  final String title;

  const PanelsPage({super.key, required this.title});

  @override
  State<PanelsPage> createState() => PanelsPageState();
}

class PlayIntent extends Intent {
  const PlayIntent();
}

class PanelsPageState extends State<PanelsPage> {
  double sidebarWidth = 0;
  double preHDragSidebarWidth = 0;

  double bottomPanelSize = 0;
  double preVDragBottomPanelSize = 0;
  double dividerHeight = 4;
  double dividerWidth = 4;
  DragStartDetails? _dragStartDetails;
  // String bottomBarMessage = 'qwe';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    var screenPadding = MediaQuery.of(context).padding;
    final bodySize =
        Size(screenSize.width - (screenPadding.left + screenPadding.right), screenSize.height - (screenPadding.top + screenPadding.bottom + kBottomNavigationBarHeight));
    // final bottomMessage = bottomBarMessage;
    return Focus(
      canRequestFocus: true,
      descendantsAreFocusable: true,
      includeSemantics: false,
      autofocus: true,
      descendantsAreTraversable: true,
      onKey: (node, event) {
        final isKeyPressed = event.isKeyPressed(event.logicalKey);
        // print('${RawKeyboard.instance.physicalKeysPressed.map((e) => 'pysical: $e -> logical: ${RawKeyboard.instance.lookUpLayout(e)}').join(', ')}');
        // print('event.logicalKey.keyLabelL: ${event.logicalKey.keyLabel}, repeat: ${event.repeat}, isKeyPressed: ${isKeyPressed}');
        // print('${node.runtimeType}: ${event.toString(minLevel: DiagnosticLevel.fine)}');
        // print('event.logicalKey.keyLabel: ${event.logicalKey.keyLabel}');
        if ((event.logicalKey.keyLabel == "a" || event.logicalKey.keyLabel == "A")) {
          // print('ctl ${event.isControlPressed}');
          if (isADown != isKeyPressed) {
            isADown = isKeyPressed;
          }
        }
        if ((event.logicalKey.keyLabel == " ")) {
          if (isSpaceDown != isKeyPressed) {
            isSpaceDown = isKeyPressed;
          }
        }
        // print('${node.runtimeType}: ${event.toString(minLevel: DiagnosticLevel.fine)}');
        if ((event.logicalKey.keyLabel == "Control Left" || event.logicalKey.keyLabel == "Control Right")) {
          if (isCtlDown.value != event.isControlPressed) {
            isCtlDown.value = (event.isControlPressed);
          }
        }
        if ((event.logicalKey.keyLabel == "Alt Left" || event.logicalKey.keyLabel == "Alt Right")) {
          if (isAltDown.value != event.isAltPressed) {
            isAltDown.value = (event.isAltPressed);
          }
        }
        if ((event.logicalKey.keyLabel == "Shift Left" || event.logicalKey.keyLabel == "Shift Right")) {
          if (isShiftDown.value != event.isShiftPressed) {
            isShiftDown.value = (event.isShiftPressed);
          }
        }
        return KeyEventResult.ignored;
      },
      child: Shortcuts(
        shortcuts: {LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.space): const PlayIntent()},
        child: Actions(
          actions: {
            PlayIntent: CallbackAction<PlayIntent>(onInvoke: (intent) {
              return null;
            }),
            // RunIntent: RunAction(),
            // StopIntent: StopAction(),
            // ResetIntent: ResetAction(),
          },
          child: Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            // bottomSheet: BottomAppBar(
            //   height: 24,
            //   elevation: 0,
            //   padding: const EdgeInsets.only(bottom: 0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text('a'), HTML.toRichText(context, bottomMessage, defaultTextStyle: theme.textTheme.labelSmall)]),
            //     ],
            //   ),
            // ),
            body:
                // CustomScrollView(slivers: [Text('123').sliverBox]),
                // endDrawer: Drawer(child: Text('asd')),
                // drawer: Drawer(child: Text('asd')),
                Stack(children: [
              if ((bodySize.height - (dividerHeight + bottomPanelSize)) > 0)
                Positioned(
                    top: 0,
                    left: 0,
                    width: bodySize.width - (sidebarWidth + dividerWidth),
                    height: (bodySize.height - (dividerHeight + bottomPanelSize)).ifNeg(0),
                    child: const EntriesPanel()),
              if (dividerHeight > 0)
                Positioned(
                  top: (bodySize.height - (dividerHeight + bottomPanelSize)).ifNeg(0),
                  left: 0,
                  width: bodySize.width - (sidebarWidth + dividerWidth),
                  height: dividerHeight,
                  child: MouseRegion(
                      cursor: SystemMouseCursors.resizeRow,
                      child: GestureDetector(
                          onVerticalDragStart: (details) => setState(() {
                                preVDragBottomPanelSize = bottomPanelSize;
                                _dragStartDetails = details;
                              }),
                          onVerticalDragCancel: () => setVDivider(dragDetails: _dragStartDetails, maxBottomPanelSize: bodySize.height - dividerHeight),
                          onVerticalDragUpdate: (details) => setVDivider(dragDetails: details, maxBottomPanelSize: bodySize.height - dividerHeight),
                          onVerticalDragEnd: (details) => setState(() {
                                preVDragBottomPanelSize = bottomPanelSize;
                              }),
                          child: Card(
                              margin: EdgeInsets.zero,
                              child: Divider(height: dividerHeight.clamp(1, kMinInteractiveDimension), thickness: 1, indent: 4, endIndent: 4, color: Colors.black)))),
                ),
              if (bottomPanelSize > 0)
                Positioned(
                  top: (bodySize.height - bottomPanelSize).ifNeg(0),
                  width: bodySize.width - sidebarWidth,
                  height: bottomPanelSize,
                  child: const BottomPanel(),
                ),
              if (dividerHeight > 0)
                Positioned(
                    top: 0,
                    left: bodySize.width - (sidebarWidth + dividerWidth),
                    width: dividerWidth,
                    height: bodySize.height,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.resizeColumn,
                        child: GestureDetector(
                            onHorizontalDragStart: (details) => setState(() {
                                  preHDragSidebarWidth = sidebarWidth;
                                  _dragStartDetails = details;
                                }),
                            onHorizontalDragCancel: () => setHDivider(dragDetails: _dragStartDetails, maxSidebarWidth: bodySize.height - dividerWidth),
                            onHorizontalDragUpdate: (details) => setHDivider(dragDetails: details, maxSidebarWidth: bodySize.height - dividerWidth),
                            onHorizontalDragEnd: (details) => setState(() {
                                  preHDragSidebarWidth = sidebarWidth;
                                }),
                            child: Card(
                                margin: EdgeInsets.zero,
                                child: VerticalDivider(width: dividerWidth.clamp(1, kMinInteractiveDimension), thickness: 1, indent: 4, endIndent: 4, color: Colors.black))))),
              if (sidebarWidth > 0)
                Positioned(
                  top: 0,
                  left: bodySize.width - sidebarWidth,
                  width: sidebarWidth,
                  height: bodySize.height,
                  child: const RightPanel(),
                ),
            ]),
          ),
        ),
      ),
    );
  }

  void setVDivider({required dynamic dragDetails, required double maxBottomPanelSize}) {
    if (dragDetails is DragStartDetails) {
      setState(() {
        bottomPanelSize = (preVDragBottomPanelSize - dragDetails.localPosition.dy).clamp(0, maxBottomPanelSize);
      });
    } else if (dragDetails is DragUpdateDetails) {
      setState(() {
        bottomPanelSize = (preVDragBottomPanelSize - dragDetails.localPosition.dy).clamp(0, maxBottomPanelSize);
      });
    } else if (dragDetails is DragEndDetails) {
    } else {
      // print('weird: $dragDetails');
    }
  }

  void setHDivider({required dynamic dragDetails, required double maxSidebarWidth}) {
    if (dragDetails is DragStartDetails) {
      setState(() {
        sidebarWidth = (preHDragSidebarWidth - dragDetails.localPosition.dx).clamp(0, maxSidebarWidth);
      });
    } else if (dragDetails is DragUpdateDetails) {
      setState(() {
        sidebarWidth = (preHDragSidebarWidth - dragDetails.localPosition.dx).clamp(0, maxSidebarWidth);
      });
    } else if (dragDetails is DragEndDetails) {
    } else {
      // print('weird: $dragDetails');
    }
  }
}
