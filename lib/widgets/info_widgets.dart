import 'package:flutter/material.dart';

class RectCropClipper extends CustomClipper<Rect> {
  final EdgeInsets edgeInsets;
  final BoxConstraints? boxConstraints;

  @override
  Rect getClip(Size size) => (edgeInsets.topLeft & ((boxConstraints?.constrain(edgeInsets.deflateSize(size))) ?? (edgeInsets.deflateSize(size))));

  @override
  Rect getApproximateClipRect(Size size) => getClip(size);

  const RectCropClipper({required this.edgeInsets, this.boxConstraints});

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return oldClipper != this;
  }
}

class RoundBadge extends StatelessWidget {
  const RoundBadge({
    super.key,
    required this.child,
    this.color = Colors.green,
    this.padding = const EdgeInsets.all(2),
    this.borderColor = const Color(0xC0FFEB3B), //Semi-translucent yellow
    this.borderWidth = 0,
    this.borderStyle = BorderStyle.solid,
    this.borderStrokeAlign = BorderSide.strokeAlignInside,
    this.borderOnForeground = false,
    this.shadowColor = Colors.transparent,
    this.elevation = 0,
  });

  final Widget child;

  /// Whether to paint the border in front of the [child].
  ///
  /// The default value is false.
  /// If true, the border may be painted on top of the [child].
  final bool borderOnForeground;

  /// The color of circle background.
  final Color color;

  /// The interior padding inside the circle background and around [child].
  final EdgeInsets padding;

  /// The color of this side of the border.
  final Color borderColor;

  final Color shadowColor;
  final double elevation;

  /// The width of this side of the border, in logical pixels.
  ///
  /// Setting width to 0.0 will result in a hairline border. This means that
  /// the border will have the width of one physical pixel. Also, hairline
  /// rendering takes shortcuts when the path overlaps a pixel more than once.
  /// This means that it will render faster than otherwise, but it might
  /// double-hit pixels, giving it a slightly darker/lighter result.
  ///
  /// To omit the border entirely, set the [style] to [BorderStyle.none].
  final double borderWidth;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none]. This skips
  /// painting the border, but the border still has a [width].
  final BorderStyle borderStyle;

  /// The direction of where the border will be drawn relative to the container.
  final double borderStrokeAlign;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: CircleBorder(side: BorderSide(style: borderStyle, width: borderWidth, color: borderColor, strokeAlign: borderStrokeAlign)),
      borderOnForeground: borderOnForeground,
      elevation: elevation,
      shadowColor: shadowColor,
      color: color,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

List<Shadow> bloomShadow(Color color, double blurRadius, double offset) => [
      Shadow(color: color, blurRadius: blurRadius, offset: Offset(-offset, -offset)),
      Shadow(color: color, blurRadius: blurRadius, offset: Offset(offset, offset)),
      Shadow(color: color, blurRadius: blurRadius, offset: Offset(-offset, offset)),
      Shadow(color: color, blurRadius: blurRadius, offset: Offset(offset, -offset)),
    ];

class RoundTextBadge extends RoundBadge {
  RoundTextBadge({
    super.key,
    required String text,
    TextStyle? textStyle,
    Color? textColor,
    FontWeight? fontWeight = FontWeight.bold,
    double? fontSize = 10,
    bool hasBloom = true,
    int bloomStrength = 2,
    double bloomRadius = 1,
    double bloomSigma = 2.4,
    Color bloomColor = Colors.white,
    super.color = const Color(0xFF00BFA5), //Colors.green,
    super.padding = const EdgeInsets.all(2),
    super.borderColor = Colors.teal, //const Color(0xC0FFEB3B), //Semi-translucent yellow
    super.borderWidth = 0,
    super.borderStyle = BorderStyle.solid,
    super.borderStrokeAlign = BorderSide.strokeAlignInside,
    super.borderOnForeground = false,
    super.shadowColor = Colors.transparent,
    super.elevation = 0,
  }) : super(
          child: Text(
            text,
            style: (textStyle ?? const TextStyle()).copyWith(
              color: textColor ?? textStyle?.color ?? Colors.black,
              fontSize: fontSize ?? textStyle?.fontSize ?? 10,
              fontWeight: fontWeight ?? textStyle?.fontWeight ?? FontWeight.bold,
              shadows: [
                ...(textStyle?.shadows ?? []),
                if (hasBloom)
                  for (int i = 0; i < bloomStrength; i++) ...bloomShadow(bloomColor, bloomSigma, bloomRadius * (1 - (i / bloomStrength))),
              ],
            ),
          ),
        );
}
