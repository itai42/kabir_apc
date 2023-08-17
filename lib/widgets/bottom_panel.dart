import 'package:flutter/material.dart';
import 'package:sem_form_core/extensions/core_extensions.dart';

class BottomPanel extends StatefulWidget {
  const BottomPanel({super.key});

  @override
  State<BottomPanel> createState() => BottomPanelState();
}

class BottomPanelState extends State<BottomPanel> {
  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    return Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      color: Colors.teal[700]!.withAlpha(50),
      child: CustomScrollView(slivers: [
        // SliverAppBar(
        //     primary: true,
        //     floating: true,
        //     titleSpacing: 0,
        //     backgroundColor: const Color(0xFFF3F3F3),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add_circle, color: Colors.teal),
        //     tooltip: 'Add new entry',
        //     onPressed: () {
        //       /* ... */
        //     },
        //   ),],),
        Card(
          child: Center(
            child: GestureDetector(
              onLongPress: () {
                // buMessageStack = DoubleLinkedQueue.of(messageStack);
                // messageStack.clear();
                // ref.refresh(messageStackProvider);
                final messenger = ScaffoldMessenger.maybeOf(context);
                messenger?.clearSnackBars();
                messenger?.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'longPressed',
                    ),
                  ),
                );
              },
              child: Text(
                "detail",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.withAlpha(150),
                  fontSize: 18,
                  // decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.blueGrey.withAlpha(150),
                ),
              ),
            ),
          ),
        ).sliverBox,
        Text('asd').sliverBox,
      ]),
    );
  }
}
