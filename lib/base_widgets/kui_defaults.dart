import 'package:flutter/material.dart';

class TransparentCard extends Card {
  const TransparentCard({
    super.key,
    super.color = Colors.transparent,
    super.shadowColor = Colors.transparent,
    super.surfaceTintColor = Colors.transparent,
    super.elevation = 0,
    super.shape,
    super.borderOnForeground = true,
    super.margin = EdgeInsets.zero,
    super.clipBehavior = Clip.hardEdge,
    super.semanticContainer = true,
    super.child,
  });
}
