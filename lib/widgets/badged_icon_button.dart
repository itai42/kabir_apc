import 'package:flutter/material.dart';
import 'package:sem_form_core/sem_form_core.dart';
import 'dart:ui';
import 'dart:math' as math;

class BadgeInfo {
  int? index;
  Offset position;
  Offset shadowOffset;
  Offset shadowSigma;
  Size size;
  Widget? widget;
  Color? color;
  Offset justify;

  BadgeInfo({
    this.index,
    required this.position,
    required this.shadowOffset,
    this.shadowSigma = const Offset(2.4, 2.4),
    required this.size,
    this.color,
    this.widget,
    this.justify = const Offset(0.5, 0.5),
  });
}

mixin Badged on Widget {
  List<BadgeInfo> get badgeInfos;

  static Iterable<Angle> generateBadgeAngles({
    required int count,
    StrictBounds<Angle> badgeAngleBounds = const StrictBounds(start: Angle.zero, end: Angle.fullCircleRad),
    Angle? setStepAngle,
    required bool? placeBadgesClockwise,
  }) sync* {
    final clockwise = placeBadgesClockwise ?? (badgeAngleBounds.start.radians >= badgeAngleBounds.end.radians);
    Angle currentAngle = clockwise ? (180.deg + badgeAngleBounds.start) : (180.deg - badgeAngleBounds.start);
    // Angle currentAngle = badgeAngleBounds.start;
    Angle spread = badgeAngleBounds.end - badgeAngleBounds.start;
    Angle stepAngle = (setStepAngle ?? (spread / count)) * (clockwise ? 1 : -1);
    for (int i = 0; i < count; i++) {
      yield currentAngle;
      currentAngle += stepAngle;
    }
  }

  static Iterable<BadgeInfo> generateBadgeInfos({
    required List<Widget> badges,
    Size badgeSize = const Size(kMinInteractiveDimension / 3, kMinInteractiveDimension / 3),
    StrictBounds<Angle> badgeAngleBounds = const StrictBounds(start: Angle.zero, end: Angle.fullCircleRad),
    required double? badgeTightness,
    required bool? placeBadgesClockwise,
    Offset radialTranslation = Offset.zero,
    required Offset center,
    double borderWidth = 1,
    Color borderColor = const Color(0x9F000000),
    double borderStrokeAlign = BorderSide.strokeAlignInside,
    bool addShadow = true,
    Offset badgeJustification = const Offset(0.5, 0.5),
    Offset badgeShadowOffset = const Offset(2, 2),
    Offset shadowSigma = const Offset(2.4, 2.4),
    List<Color> badgeShadowColorGradient = const [Colors.teal],
  }) sync* {
    final count = badges.length;
    final badgeAngles = generateBadgeAngles(
      count: count,
      badgeAngleBounds: badgeAngleBounds,
      setStepAngle: badgeTightness != null ? Angle.fromBisector(bisectorLength: badgeTightness * badgeSize.longestSide, radius: center.shortestSide) : null,
      placeBadgesClockwise: placeBadgesClockwise,
    ).toListNG();
    final gradientColors =
        ColorUtils.lerpLinearGradient(colors: badgeShadowColorGradient, stops: ColorUtils.lerp(0, 1, count).toListNG(), growable: false, tileMode: TileMode.clamp).toListNG();
    for (int i = 0; i < count; i++) {
      final unitVector = badgeAngles[i].unitVector;
      yield BadgeInfo(
          widget: badges[i],
          size: badgeSize,
          shadowOffset: badgeShadowOffset.multiplyComponents(unitVector),
          shadowSigma: shadowSigma,
          index: i,
          justify: badgeJustification,
          position: center - (radialTranslation + center).multiplyComponents(unitVector),
          color: gradientColors[i]);
    }
  }

  // Iterable<BadgeInfo> getBadgeInfos() sync*{
  //   final badgeInfos = this.badgeInfos;
  //   final nBadges = badgeInfos.length;
  //   final placeBadgesClockwise = this.placeBadgesClockwise??badgeAngleBounds.start.radians > badgeAngleBounds.end.radians;
  //   Angle curAngle = placeBadgesClockwise?(180.deg + badgeAngleBounds.start) : (180.deg - badgeAngleBounds.start);
  //   for (int i = 0; i < nBadges; i++) {
  //     final badge = badges[i];
  //     final spread = badgeAngleBounds.end - badgeAngleBounds.start;
  //     Offset((kRadialReactionRadius) - unitVector.dx * kRadialReactionRadius, (kRadialReactionRadius) - (unitVector.dy * kRadialReactionRadius)
  //   }
  // }
  Widget buildWithBadges(BuildContext context, List<Widget> children) {
    // final directionality = Directionality.of(context);
    return Stack(children: [
      ...children,
      ...badgeInfos.expand((badgeInfo) => (badgeInfo.widget == null)
          ? <Widget>[]
          : <Widget>[
              IgnorePointer(
                  child: Transform.translate(
                      offset: badgeInfo.position + badgeInfo.shadowOffset + (badgeInfo.size.toOffset().multiplyComponents(badgeInfo.justify - const Offset(1, 1))),
                      child: SizedBox(
                        width: badgeInfo.size.width,
                        height: badgeInfo.size.height,
                        child: FittedBox(
                          alignment: AlignmentDirectional.topStart,
                          fit: BoxFit.cover,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: badgeInfo.shadowSigma.dx,
                              sigmaY: badgeInfo.shadowSigma.dy,
                            ),
                            enabled: true, //ToDo: check device performance settings to set this off
                            child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: const [0, 1],
                                      tileMode: TileMode.clamp,
                                      colors: <Color>[badgeInfo.color ?? Colors.black, badgeInfo.color ?? Colors.black],
                                    ).createShader(bounds),
                                child: badgeInfo.widget),
                          ),
                        ),
                      ))),
              IgnorePointer(
                  child: Transform.translate(
                offset: badgeInfo.position + (badgeInfo.size.toOffset().multiplyComponents(badgeInfo.justify - const Offset(1, 1))),
                child: SizedBox(
                    width: badgeInfo.size.width,
                    height: badgeInfo.size.height,
                    child: FittedBox(
                      alignment: AlignmentDirectional.topStart,
                      fit: BoxFit.cover,
                      child: badgeInfo.widget!,
                    )),
              )),
            ]),
    ]);
    //     // child:
    //     //          badgeInfo.widget,
    //     //               )))),
    //     //     ]));
    //     //
    // return Badged(
    //     badgeSize: badgeSize,
    //     badgePosition:
    //     Offset((kRadialReactionRadius) - unitVector.dx * kRadialReactionRadius, (kRadialReactionRadius) - (unitVector.dy * kRadialReactionRadius)
    //     ),
    //     badge: Container(
    //         color: Colors.transparent,
    //         child: Stack(children: [
    //           Transform.translate(
    //               offset: const Offset(2, 2),
    //               child: ImageFiltered(
    //                   imageFilter: ImageFilter.blur(
    //                     sigmaX: 3,
    //                     sigmaY: 3,
    //                   ),
    //                   enabled: true,
    //                   child: badge)), //const Icon(Icons.account_circle, size: 32, color: Colors.black)
    //           badge,
    //         ])),
    //     child: Card(elevation: 0,
    //         margin: EdgeInsets.symmetric(horizontal: iconSize.width / 2, vertical: iconSize.height / 2),
    //         shape: iconBorderShape,
    //         color: Colors.green,
    //         child: IconButton(
    //             icon: const Icon(Icons.add),
    //             style: ButtonStyle(shape: MaterialStatePropertyAll(iconBorderShape)),
    //             splashRadius: kRadialReactionRadius - 1,
    //             iconSize: kRadialReactionRadius,
    //             onPressed: () {})));
  }

  Widget buildWithBadges_01(BuildContext context, List<Widget> children) {
    // final directionality = Directionality.of(context);
    return Stack(children: [
      ...children,
      ...badgeInfos.expand((badgeInfo) => (badgeInfo.widget == null)
          ? <Widget>[]
          : <Widget>[
              IgnorePointer(
                  child: Transform.translate(
                      offset: badgeInfo.position + badgeInfo.shadowOffset + (badgeInfo.size.toOffset().multiplyComponents(badgeInfo.justify - const Offset(1, 1))),
                      child: SizedBox(
                        width: badgeInfo.size.width,
                        height: badgeInfo.size.height,
                        child: FittedBox(
                          alignment: AlignmentDirectional.topStart,
                          fit: BoxFit.cover,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: badgeInfo.shadowSigma.dx,
                              sigmaY: badgeInfo.shadowSigma.dy,
                            ),
                            enabled: true, //ToDo: check device performance settings to set this off
                            child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: const [0, 1],
                                      tileMode: TileMode.clamp,
                                      colors: <Color>[badgeInfo.color ?? Colors.black, badgeInfo.color ?? Colors.black],
                                    ).createShader(bounds),
                                child: badgeInfo.widget),
                          ),
                        ),
                      ))),
              IgnorePointer(
                  child: Transform.translate(
                offset: badgeInfo.position + (badgeInfo.size.toOffset().multiplyComponents(badgeInfo.justify - const Offset(1, 1))),
                child: SizedBox(
                    width: badgeInfo.size.width,
                    height: badgeInfo.size.height,
                    child: FittedBox(
                      alignment: AlignmentDirectional.topStart,
                      fit: BoxFit.fill,
                      child: badgeInfo.widget!,
                    )),
              )),
            ]),
    ]);
    //     // child:
    //     //          badgeInfo.widget,
    //     //               )))),
    //     //     ]));
    //     //
    // return Badged(
    //     badgeSize: badgeSize,
    //     badgePosition:
    //     Offset((kRadialReactionRadius) - unitVector.dx * kRadialReactionRadius, (kRadialReactionRadius) - (unitVector.dy * kRadialReactionRadius)
    //     ),
    //     badge: Container(
    //         color: Colors.transparent,
    //         child: Stack(children: [
    //           Transform.translate(
    //               offset: const Offset(2, 2),
    //               child: ImageFiltered(
    //                   imageFilter: ImageFilter.blur(
    //                     sigmaX: 3,
    //                     sigmaY: 3,
    //                   ),
    //                   enabled: true,
    //                   child: badge)), //const Icon(Icons.account_circle, size: 32, color: Colors.black)
    //           badge,
    //         ])),
    //     child: Card(elevation: 0,
    //         margin: EdgeInsets.symmetric(horizontal: iconSize.width / 2, vertical: iconSize.height / 2),
    //         shape: iconBorderShape,
    //         color: Colors.green,
    //         child: IconButton(
    //             icon: const Icon(Icons.add),
    //             style: ButtonStyle(shape: MaterialStatePropertyAll(iconBorderShape)),
    //             splashRadius: kRadialReactionRadius - 1,
    //             iconSize: kRadialReactionRadius,
    //             onPressed: () {})));
  }
}

class BadgedIconButton extends StatelessWidget with Badged {
  //Defaults to a circle

  final List<Widget> children;
  final List<Widget> badges;
  final bool placeInCard;
  final Size size;
  final Size badgeSize;
  final StrictBounds<Angle> badgeAngleBounds;
  final double? badgeTightness;
  final Color color;
  final Color cardShadowColor;
  final bool keepBadgeEdgeMargin;

  /// if null direction will be derived from badgeAngleBounds (counter clockwise if badgeAngleBounds.start < badgeAngleBounds.end and clocwise if badgeAngleBounds.start > badgeAngleBounds.end
  final bool? placeBadgesClockwise;
  final Offset badgeRadialTranslation;
  final double borderWidth;
  final Color borderColor;
  final double borderStrokeAlign;
  final Color? badgeShadowColor;
  final Offset? badgeShadowOffset;
  final Offset badgeJustification;
  final Offset shadowSigma;
  final OutlinedBorder? iconBorderShape;
  final double? iconSplashRadius;
  final double? elevation;

  BadgedIconButton({
    super.key,
    this.size = const Size(kMinInteractiveDimension, kMinInteractiveDimension),
    this.badgeSize = const Size(kMinInteractiveDimension / 3, kMinInteractiveDimension / 3),
    this.borderColor = const Color(0x9F000000),
    this.borderStrokeAlign = BorderSide.strokeAlignInside,
    this.badgeAngleBounds = const StrictBounds(start: Angle.zero, end: Angle.fullCircleRad),
    this.badgeTightness = 0.8,
    this.badgeRadialTranslation = Offset.zero,
    this.keepBadgeEdgeMargin = false,
    this.borderWidth = 1,
    this.placeBadgesClockwise,
    this.badgeShadowColor,
    this.badgeJustification = const Offset(0.5, 0.5),
    this.badgeShadowOffset,
    this.shadowSigma = const Offset(2.4, 2.4),
    this.iconBorderShape,
    this.iconSplashRadius,
    this.color = const Color(0x9F009688),
    this.cardShadowColor = Colors.transparent,
    this.elevation,
    this.placeInCard = true,
    this.badges = const [],
    this.children = const [],
  });

  @override
  List<BadgeInfo> get badgeInfos => Badged.generateBadgeInfos(
        badges: badges,
        badgeSize: badgeSize,
        badgeAngleBounds: badgeAngleBounds,
        badgeTightness: badgeTightness,
        placeBadgesClockwise: placeBadgesClockwise,
        radialTranslation: badgeRadialTranslation,
        center: (size.toOffset() - badgeSize.toOffset() / 2) / 2,
        borderWidth: borderWidth,
        borderColor: borderColor,
        borderStrokeAlign: borderStrokeAlign,
        addShadow: badgeShadowColor != null,
        shadowSigma: shadowSigma,
        badgeJustification: badgeJustification,
        badgeShadowOffset: badgeShadowOffset ?? Offset.zero,
        badgeShadowColorGradient: [badgeShadowColor ?? Colors.transparent],
      ).toListNG();

  @override
  Widget build(BuildContext context) {
    final iconShape = iconBorderShape ?? CircleBorder(side: BorderSide(style: BorderStyle.solid, color: borderColor, width: borderWidth, strokeAlign: borderStrokeAlign));

    if (!placeInCard) {
      return buildWithBadges(context, children);
    }
    return //IntrinsicWidth(child: IntrinsicHeight(child:
        Padding(
            padding: (!keepBadgeEdgeMargin)
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(horizontal: math.max(0, badgeSize.width / 2 - borderWidth), vertical: math.max(0, badgeSize.height / 4 - borderWidth)),
            child: Card(
              margin: EdgeInsets.zero,
              //(!keepBadgeEdgeMargin)?:EdgeInsets.symmetric(horizontal: math.max(0, badgeSize.width / 2 - borderWidth), vertical: math.max(0, badgeSize.height / 4 - borderWidth)),
              shape: iconShape,
              borderOnForeground: false,
              clipBehavior: Clip.none,
              color: color,
              shadowColor: cardShadowColor,
              elevation: elevation,
              child: buildWithBadges(context, children),
            )); //));
  }
}
//
// class BadgedIconButtonState extends State<BadgedIconButton> {
//
//   late final CircleBorder iconBorderShape;
//
//   BadgedIconButtonState() {
//     iconBorderShape = CircleBorder(side: BorderSide(style: BorderStyle.solid, color: widget.borderColor, width: widget.borderWidth, strokeAlign: widget.borderStrokeAlign));
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final directionality = Directionality.of(context);
//     return Badged(
//         badgeSize: widget.badgeSize,
//         badgePosition:
//         ),
//         badge: Container(
//             color: Colors.transparent,
//             child: Stack(children: [
//               Transform.translate(
//                   offset: const Offset(2, 2),
//                   child: ImageFiltered(
//                       imageFilter: ImageFilter.blur(
//                         sigmaX: 3,
//                         sigmaY: 3,
//                       ),
//                       enabled: true,
//                       child: widget.badge)), //const Icon(Icons.account_circle, size: 32, color: Colors.black)
//               widget.badge,
//             ])),
//         child: Card(elevation: 0,
//             margin: EdgeInsets.symmetric(horizontal: widget.iconSize.width / 2, vertical: widget.iconSize.height / 2),
//             shape: iconBorderShape,
//             color: Colors.green,
//             child: IconButton(
//                 icon: const Icon(Icons.add),
//                 style: ButtonStyle(shape: MaterialStatePropertyAll(iconBorderShape)),
//                 splashRadius: kRadialReactionRadius - 1,
//                 iconSize: kRadialReactionRadius,
//                 onPressed: () {})));
//   }
// }
