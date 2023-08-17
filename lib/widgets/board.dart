// import 'package:flutter/material.dart';
// import 'package:sem_form_core/sem_form_core.dart';
//
// class SemfBoard extends StatefulWidget {
//   const SemfBoard({super.key});
//
//   @override
//   State<SemfBoard> createState() => SemfBoardState();
// }
//
// class SemfBoardState extends State<SemfBoard> {
//   late DraggableScrollableController draggableScrollableController;
//   @override
//   void initState() {
//     super.initState();
//     draggableScrollableController = DraggableScrollableController();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  DraggableScrollableSheet(controller: draggableScrollableController, minChildSize: 0.01, maxChildSize: 1000, initialChildSize: 10, builder: ,);
//   }
// }
//
// enum PaintLayer {
//   under,
//   interm,
//   over,
// }
//
// mixin SemfBoardInstructor {
//   //override this to get notified when redraw needs to be done
//   bool markedDirty = true;
//
//   void markNeedRedraw() {
//     // var preOvercnt = _preOverPaintInstructions.length;
//     // var overcnt = _overPaintInstructions.length;
//     // var postOvercnt = _postOverPaintInstructions.length;
//     // var cnt = _paintInstructions.length;
//     // var preUndercnt = _preUnderPaintInstructions.length;
//     // var undercnt = _underPaintInstructions.length;
//     // var postUndercnt = _postUnderPaintInstructions.length;
//     //print("preOvercnt: $preOvercnt, overcnt: $overcnt, postOvercnt: $postOvercnt, cnt: $cnt, preUndercnt: $preUndercnt, undercnt: $undercnt, postUndercnt: $postUndercnt");
//     markedDirty = true;
//   }
//
//   Map<String, AddedPaintInstructionCallback> _preOverPaintInstructions = {};
//   Map<String, AddedPaintInstructionCallback> _overPaintInstructions = {};
//   Map<String, AddedPaintInstructionCallback> _postOverPaintInstructions = {};
//   Map<String, AddedPaintInstructionCallback> _paintInstructions = {};
//   Map<String, AddedPaintInstructionCallback> _preUnderPaintInstructions = {};
//   Map<String, AddedPaintInstructionCallback> _underPaintInstructions = {};
//   Map<String, AddedPaintInstructionCallback> _postUnderPaintInstructions = {};
//
//   int get postOverPaintCount => _postOverPaintInstructions.length;
//
//   int get preOverPaintCount => _preOverPaintInstructions.length;
//
//   int get overPaintCount => _overPaintInstructions.length;
//
//   int get paintCount => _paintInstructions.length;
//
//   int get preUnderPaintCount => _preUnderPaintInstructions.length;
//
//   int get underPaintCount => _underPaintInstructions.length;
//
//   int get postUnderPaintCount => _postUnderPaintInstructions.length;
//
//   bool get anyPaintInstructions =>
//       _preOverPaintInstructions.isNotEmpty ||
//           _preUnderPaintInstructions.isNotEmpty ||
//           _underPaintInstructions.isNotEmpty ||
//           _paintInstructions.isNotEmpty ||
//           _postOverPaintInstructions.isNotEmpty ||
//           _postUnderPaintInstructions.isNotEmpty ||
//           _overPaintInstructions.isNotEmpty;
//
//   bool get hasUnderInstructions => _preUnderPaintInstructions.isNotEmpty || _postUnderPaintInstructions.isNotEmpty || _underPaintInstructions.isNotEmpty;
//
//   bool get hasPaintInstructions => _paintInstructions.isNotEmpty;
//
//   bool get hasOverInstructions => _preOverPaintInstructions.isNotEmpty || _postOverPaintInstructions.isNotEmpty || _overPaintInstructions.isNotEmpty;
//
//   void registerPreUnderPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _preUnderPaintInstructions[paintId] = callback;
//     markNeedRedraw();
//   }
//
//   void unregisterPreUnderPaint(String paintId) {
//     if (_preUnderPaintInstructions.containsKey(paintId)) {
//       _preUnderPaintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void registerUnderPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _underPaintInstructions[paintId] = callback;
//     markNeedRedraw();
//   }
//
//   void unregisterUnderPaint(String paintId) {
//     if (_underPaintInstructions.containsKey(paintId)) {
//       _underPaintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void registerPostUnderPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _postUnderPaintInstructions[paintId] = callback;
//     markNeedRedraw();
//   }
//
//   void unregisterPostUnderPaint(String paintId) {
//     if (_postUnderPaintInstructions.containsKey(paintId)) {
//       _postUnderPaintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void registerPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _paintInstructions[paintId] = callback;
//     markNeedRedraw();
//   }
//
//   void unregisterPaint(String paintId) {
//     if (_paintInstructions.containsKey(paintId)) {
//       _paintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void registerPreOverPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _preOverPaintInstructions[paintId] = callback;
//     markNeedRedraw();
//   }
//
//   void unregisterPreOverPaint(String paintId) {
//     if (_preOverPaintInstructions.containsKey(paintId)) {
//       _preOverPaintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void registerOverPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _overPaintInstructions[paintId] = callback;
//     markNeedRedraw();
//   }
//
//   void unregisterOverPaint(String paintId) {
//     if (_overPaintInstructions.containsKey(paintId)) {
//       _overPaintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void registerPostOverPaint(AddedPaintInstructionCallback callback, String paintId) {
//     _postOverPaintInstructions[paintId] = callback;
//     //print("Added $callback (${_postOverPainInstructions.length})");
//     markNeedRedraw();
//   }
//
//   void unregisterPostOverPaint(String paintId) {
//     if (_postOverPaintInstructions.containsKey(paintId)) {
//       _postOverPaintInstructions.remove(paintId); //allows reordering by repeated registration //ToDo: better ordering mechanism
//     }
//     markNeedRedraw();
//   }
//
//   void unregisterAllPaint(String paintId) {
//     unregisterPreUnderPaint(paintId);
//     unregisterUnderPaint(paintId);
//     unregisterPostUnderPaint(paintId);
//     unregisterPaint(paintId);
//     unregisterPreOverPaint(paintId);
//     unregisterOverPaint(paintId);
//     unregisterPostOverPaint(paintId);
//     markNeedRedraw();
//   }
//
//   bool onPreUnderPaint(Canvas canvas, Size size) {
//     var pupi = _preUnderPaintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in pupi) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: true, isOverPaint: true);
//     }
//     return anyChanges;
//   }
//
//   bool onUnderPaint(Canvas canvas, Size size) {
//     var upi = _underPaintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in upi) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: false, isOverPaint: false);
//     }
//     return anyChanges;
//   }
//
//   bool onPostUnderPaint(Canvas canvas, Size size) {
//     var pupi = _postUnderPaintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in pupi) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: false, isOverPaint: true);
//     }
//     return anyChanges;
//   }
//
//   bool onPaint(Canvas canvas, Size size) {
//     var pai = _paintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in pai) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: false, isOverPaint: false);
//     }
//     return anyChanges;
//   }
//
//   bool onPreOverPaint(Canvas canvas, Size size) {
//     var popi = _preOverPaintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in popi) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: true, isOverPaint: true);
//     }
//     return anyChanges;
//   }
//
//   bool onOverPaint(Canvas canvas, Size size) {
//     var opi = _overPaintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in opi) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: false, isOverPaint: true);
//     }
//     return anyChanges;
//   }
//
//   bool onPostOverPaint(Canvas canvas, Size size) {
//     var popi = _postOverPaintInstructions.values;
//     bool anyChanges = false;
//     for (var inst in popi) {
//       anyChanges |= inst(canvas: canvas, size: size, isPre: false, isOverPaint: true);
//     }
//     return anyChanges;
//   }
//
//   void paintInstructions(Canvas canvas, Size size, PaintLayer paintLayer) {
//     //print("paintInstructions: $canvas, $size");
//     if (paintLayer == PaintLayer.under) {
//       //canvas.drawRect(Rect.fromPoints(Offset(0,0), size.toOffset()), Paint()..color = Colors.white);
//       canvas.saveLayer(null, Paint());
//       onPreUnderPaint(canvas, size);
//       canvas.restore();
//       canvas.saveLayer(null, Paint());
//       onUnderPaint(canvas, size);
//       canvas.restore();
//       canvas.saveLayer(null, Paint());
//       onPostUnderPaint(canvas, size);
//       canvas.restore();
//     }
//     if (paintLayer == PaintLayer.interm) {
//       canvas.saveLayer(null, Paint());
//       onPaint(canvas, size);
//       canvas.restore();
//     }
//
//     if (paintLayer == PaintLayer.over) {
//       canvas.saveLayer(null, Paint());
//       onPreOverPaint(canvas, size);
//       canvas.restore();
//       canvas.saveLayer(null, Paint());
//       onOverPaint(canvas, size);
//       canvas.restore();
//       canvas.saveLayer(null, Paint());
//       onPostOverPaint(canvas, size);
//       canvas.restore();
//     }
//     markedDirty = false;
//   }
//
//   bool shouldRepaint(SemfBoardPainter oldPainter) => anyPaintInstructions;
//
//   bool hitTest(Offset position) => false;
// }
// class SemfBoardPainter extends CustomPainter {
//   SemfBoardPainter({
//     this.axisIntersect, //Optional offset at which to draw axis with a different color. if null - none is drawn,
//     this.divisions = 2, //if null - none is drawn,
//     this.subdivisions = 10,
//     this.interval = 100,
//   this.gridColor = defaultGridColor,
//   this.axisColorX = defaultAxisColor,
//   this.axisColorY = defaultAxisColor,
//     this.levelColors,
//     this.drawAxisLegendX = false,
//     this.drawAxisLegendY = false,
//     this.paintLayer = PaintLayer.interm,
//     this.shouldHitTest = false,
//    this.currentSize = minActionSize,
//         this.initialScale = const Size(1, 1),
//         this.initialScrollOffset = const Offset(0, 0),
//     this.child,
//   }) : currentScale = initialScale, currentScrollOffset = initialScrollOffset;
//
//
//   static const minActionSize = Size(32, 32);
//
//   final Widget? child;
//   final PaintLayer paintLayer;
//
//   bool gridPaintInstruction({required Canvas canvas, required Size size, required bool isPre, required bool isOverPaint}) {
//     paintGrid(canvas, size);
//     return true;
//   }
//
//   bool drawAxisLegendY;
//   bool drawAxisLegendX;
//   final Offset? axisIntersect;
//   final Color gridColor;
//   final Color? axisColorX;
//   final Color? axisColorY;
//   final Map<int, Color>? levelColors;
//   final double interval;
//   final int divisions;
//   final int subdivisions;
//   static const Color defaultGridColor = const Color.fromARGB(32, 135, 108, 27);
//   static const Color defaultAxisColor = const Color.fromARGB(32, 88, 134, 46);
//   static const Color defaultIntersectColor = const Color.fromARGB(32, 255, 0, 0);
//
//   Offset currentScrollOffset;
//   Size currentSize;
//   Size currentScale;
//   final Offset initialScrollOffset;
//   final Size initialScale;
//
//   int currentLevel = 0;
//   bool markedDirty = true;
//
//   final bool shouldHitTest;
//
//   @override
//   bool hitTest(Offset position) => shouldHitTest;
//   var neverRegistered = true;
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (paintLayer == PaintLayer.under && neverRegistered) {
//       registerUnderPaint(gridPaintInstruction, "mainUnderGrid"); //todo: make names unlikely to duplicate
//     }
//
//     if (paintLayer == PaintLayer.over && neverRegistered) {
//       registerOverPaint(gridPaintInstruction, "mainOverGrid");
//     }
//
//     //print("laChartBoard.anyPaintInstructions: ${laChartBoard.anyPaintInstructions}");
//     paintInstructions(canvas, size, paintLayer);
//
//     neverRegistered = false;
//   }
//
//   Color levelLineColor(int level) {
//     if (levelColors?.containsKey(currentLevel) ?? false) {
//       return levelColors![currentLevel]!;
//     }
//     return gridColor;
//   }
//
//   void paintGrid(Canvas canvas, Size size) {
//     //ToDo: allow logarithmic grid
//     currentLevel = 0;
//     final Paint linePaint = Paint();
//     final Paint markLinePaint = Paint();
//     final divInterval = interval / divisions;
//     final subInterval = divInterval / (subdivisions);
//     for (int drawingLevel = 2; drawingLevel >= 0; drawingLevel--) {
//       //Drawing subDivisions, then divisions, then intervals (and finally axis outside this loop - after it ends)
//       currentLevel = drawingLevel;
//       final double stride = (drawingLevel == 0)
//           ? interval
//           : (drawingLevel == 1)
//           ? divInterval
//           : subInterval;
//       linePaint.color = levelLineColor(currentLevel);
//       markLinePaint.color = levelLineColor(currentLevel).withAlpha((levelLineColor(currentLevel).alpha + 50).max(255));
//       markLinePaint.strokeWidth = 1.5;
//       linePaint.strokeWidth = (drawingLevel == 0)
//           ? 1
//           : (drawingLevel == 1)
//           ? 0.5
//           : 0.25;
//       int xIntersect = ((axisIntersect?.dx) ?? 0).toInt();
//       int yIntersect = ((axisIntersect?.dy) ?? 0).toInt();
//       for (double x = 0.0; x <= size.width; x += stride) {
//         if (drawingLevel == 0 || ((x % interval != 0) && (drawingLevel != 2 || (x % divInterval) != 0))) {
//           canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), linePaint);
//           int xCoord = (x - ((axisIntersect?.dx) ?? 0)).toInt();
//           if (drawingLevel == 0 && drawAxisLegendX) {
//             final textStyle = TextStyle(
//               color: Colors.black,
//               fontSize: 12,
//             );
//             final textSpan = TextSpan(
//               text: '$xCoord',
//               style: textStyle,
//             );
//             final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.right);
//             textPainter.layout(
//               minWidth: 0,
//               maxWidth: stride,
//             );
//             //final yCenter = textPainter.height + 2;
//             final xCenter = (textPainter.width / ((xCoord == 0) ? 1 : 2)) + ((xCoord == 0) ? 6 : 1);
//             textPainter.paint(canvas, Offset(x - xCenter, yIntersect + 3));
//             if (xCoord != 0 || !drawAxisLegendY) {
//               canvas.drawLine(Offset(x, yIntersect - 3), Offset(x, yIntersect + 3), markLinePaint);
//             }
//           }
//         }
//       }
//       for (double y = 0.0; y <= size.height; y += stride) {
//         if (drawingLevel == 0 || ((y % interval != 0) && (drawingLevel != 2 || (y % divInterval) != 0))) {
//           canvas.drawLine(Offset(0.0, y), Offset(size.width, y), linePaint);
//           if (drawingLevel == 0 && drawAxisLegendY) {
//             int yCoord = (y - ((axisIntersect?.dy) ?? 0)).toInt();
//             final textStyle = TextStyle(
//               color: Colors.black,
//               fontSize: 12,
//             );
//             final textSpan = TextSpan(
//               text: '$yCoord',
//               style: textStyle,
//             );
//             final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.right);
//             textPainter.layout(
//               minWidth: 0,
//               maxWidth: size.width / 2,
//             );
//             // final xCenter = (size.width - textPainter.width) / 2;
//             final yCenter = ((yCoord == 0) ? 0 : textPainter.height / 2) + ((yCoord == 0) ? -3 : 1);
//             // final offset = Offset(xCenter, yCenter);
//             textPainter.paint(canvas, Offset(xIntersect - textPainter.width - 6, y - yCenter));
//
//             if (yCoord != 0) {
//               canvas.drawLine(Offset(xIntersect - 3, y), Offset(xIntersect + 3, y), markLinePaint);
//             }
//           }
//         }
//       }
//     }
//     if (axisIntersect != null) {
//       linePaint.strokeWidth = 1.4;
//       if (axisColorX != null && axisColorX!.alpha > 0) {
//         linePaint.color = axisColorX ?? defaultAxisColor;
//         canvas.drawLine(Offset(axisIntersect!.dx, 0.0), Offset(axisIntersect!.dx, size.height), linePaint);
//       }
//       if (axisColorY != null && axisColorY!.alpha > 0) {
//         linePaint.color = axisColorY ?? defaultAxisColor;
//         canvas.drawLine(Offset(0.0, axisIntersect!.dy), Offset(size.width, axisIntersect!.dy), linePaint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(SemfBoardPainter oldPainter) {
//     //ToDo:! split by paint layer
//     return markedDirty ||
//         oldPainter.child != child;
//   }
//
// }