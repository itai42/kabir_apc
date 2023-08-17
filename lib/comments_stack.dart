import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collapsible/collapsible.dart';

import 'utils/extensions.dart';


typedef RefWidgetBuilder = Widget Function(BuildContext context, {required CommentsStackWidget CommentsStackWidget, required Widget child});

/// Signature of callbacks that have no arguments and returns a boolean.
typedef BooleanCallback = void Function();

class CommentsStackWidget extends StatefulWidget {
  /// The components contained within the sub-menu.
  final Widget child;
  final Widget? collapsedChild;

  /// The initial state of the sub-menu, whether it's visible or not.
  final bool initiallyCollapsed;

  /// The axes the widget will collapse/expand along.
  final CollapsibleAxis axis;

  /// If `true`, the [child] will fade in/out during the
  /// collapsing/expanding animation.
  final bool fade;

  /// The value the width of the child is multiplied by when
  /// the widget is in its collapsed state.
  ///
  /// [minWidthFactor] will not affect the size of the child if
  /// [axis] equals `CollapsibleAxis.vertical`.
  final double minWidthFactor;

  /// The value the height of the child is multiplied by when
  /// the widget is in its collapsed state.
  ///
  /// [minHeightFactor] will not affect the size of the child if
  /// [axis] equals `CollapsibleAxis.horizontal`.
  final double minHeightFactor;

  /// If [fade] is `true`, the opacity will be transitioned to
  /// [minOpacity] when the widget is in its collapsed state.
  final double minOpacity;

  /// The duration of the collapsing/expanding animation.
  final Duration duration;

  /// The alignment of the [child] within the [ClipRect] wrapping it.
  final AlignmentGeometry alignment;

  /// The easing curve applied to the collapsing/expanding animation.
  final Curve curve;

  /// The clipping behavior applied to the [ClipRect] that wraps the [child].
  final Clip clipBehavior;

  /// A callback called every time the animation completes.
  final VoidCallback? onComplete;

  /// If `false`, the [child] will be replaced with a `SizedBox.shrink()`
  /// when the [Collapsible] is in its collapsed state, if `true`, the
  /// [child] will remain built when collapsed.
  ///
  /// [maintainState] will be set to `true` by default if [minWidthFactor]
  /// or [minHeightFactor] is `> 0.0` and [axis] affects the horizontal or
  /// vertical axes respectively, as the [child] will still occupy space
  /// when in the collapsed state in those cases.
  final bool maintainState;

  /// If `false`, the [child] and its sub-tree's animation tickers, if it
  /// has any, will be paused when in the collapsed state, if `true`, they
  /// will continue running.
  ///
  /// The tickers will be paused regardless of whether the child is still
  /// visible in the collapsed state unless [maintainAnimation] is set to
  /// `true`.
  final bool maintainAnimation;

  final VoidCallback? onLongPress;
  final BooleanCallback? onExpanding;
  final BooleanCallback? onCollapsing;

  final RefWidgetBuilder sizingBuilder;
  final RefWidgetBuilder containerBuilder;
  final RefWidgetBuilder childBuilder;
  final Widget? expandedIcon;
  final Widget? collapsedIcon;
  final double? expandedIconSize;
  final double? collapsedIconSize;
  final double? expandedIconSplashSize;
  final double? collapsedIconSplashSize;

  final Color cardColor;
  final Color cardShadowColor;

  const CommentsStackWidget({
    super.key,
    required this.child,
    this.collapsedChild,
    this.initiallyCollapsed = false,
    this.axis = CollapsibleAxis.both,
    this.alignment = AlignmentDirectional.topStart,
    this.minWidthFactor = 0.0,
    this.minHeightFactor = 0.0,
    this.fade = false,
    this.minOpacity = 0.0,
    this.duration = const Duration(milliseconds: 240),
    this.curve = Curves.easeOut,
    this.clipBehavior = Clip.hardEdge,
    this.onComplete,
    bool maintainState = false,
    this.maintainAnimation = true,
    this.sizingBuilder = defaultSizingBuilder,
    this.containerBuilder = defaultContainerBuilder,
    this.childBuilder = defaultChildBuilder,
    this.expandedIcon,
    this.collapsedIcon,
    this.expandedIconSize,
    this.collapsedIconSize,
    this.expandedIconSplashSize,
    this.collapsedIconSplashSize,
    this.onLongPress,
    this.onExpanding,
    this.onCollapsing,
    this.cardColor =  const Color(0x10FFC107),
    this.cardShadowColor =  const Color(0x00FFC107),
  })  : assert(minWidthFactor >= 0.0 && minWidthFactor <= 1.0),
        assert(minHeightFactor >= 0.0 && minHeightFactor <= 1.0),
        assert(minOpacity >= 0.0 && minOpacity <= 1.0),
        maintainState =
            maintainState || maintainAnimation || (axis != CollapsibleAxis.vertical && minWidthFactor > 0.0) || (axis != CollapsibleAxis.horizontal && minHeightFactor > 0.0);

  @override
  State<CommentsStackWidget> createState() => CommentsStackWidgetState();

  static Widget defaultChildBuilder(BuildContext context, {required CommentsStackWidget CommentsStackWidget, required Widget child}) => child;

  static Widget defaultSizingBuilder(BuildContext context, {required CommentsStackWidget CommentsStackWidget, required Widget child}) =>
      ConstrainedBox(constraints: BoxConstraints.loose(const Size(400, 400)), child: child);

  // static Widget defaultSizingBuilder(BuildContext context, WidgetRef ref, {required Widget child}) => IntrinsicHeight(child: IntrinsicWidth(child: child));

  static Widget defaultContainerBuilder(BuildContext context, {required CommentsStackWidget CommentsStackWidget, required Widget child}) =>
      //SingleChildScrollView(
  //child:
  Card(elevation: 0,
    margin: EdgeInsets.zero,
    color: CommentsStackWidget.cardColor,
    shadowColor: CommentsStackWidget.cardShadowColor, //Colors.brown.shade100.withOpacity(0.2),
    child: SingleChildScrollView(padding: EdgeInsets.zero, child: child),
    // )
  );
}

class CommentsStackWidgetState extends State<CommentsStackWidget> {
  bool expandLayers = true;

  static const defaultExpandedIcon = Icon(Icons.arrow_drop_down_circle_rounded);
  static final defaultCollapsedIcon = Transform.rotate(angle: pi / 2, child: const Icon(Icons.arrow_drop_down_circle_sharp));

  late final Widget expandedIcon;
  late final Widget collapsedIcon;

  get onLongPress => widget.onLongPress;

  get onExpanding => widget.onExpanding ?? () => true;

  get onCollapsing => widget.onCollapsing ?? () => true;


  // CommentsStackWidgetState() ;
  @override
  void initState() {
    super.initState();
    expandLayers = !widget.initiallyCollapsed;
    expandedIcon = widget.expandedIcon ?? defaultExpandedIcon;
    collapsedIcon = widget.collapsedIcon ?? defaultCollapsedIcon;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expandedIconSize = widget.expandedIconSize ?? theme.iconTheme.size ?? 24;
    final collapsedIconSize = widget.collapsedIconSize ?? theme.iconTheme.size ?? 24;
    final expandedIconSplashSize = widget.expandedIconSplashSize ?? expandedIconSize;
    final collapsedIconSplashSize = widget.collapsedIconSplashSize ?? collapsedIconSize;
    // final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Stack(textDirection: Directionality.of(context).reverse, fit: StackFit.loose,clipBehavior: Clip.hardEdge,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Collapsible(
            collapsed: !expandLayers,
            axis: widget.axis,
            alignment: widget.alignment,
            minWidthFactor: widget.minWidthFactor,
            minHeightFactor: widget.minHeightFactor,
            fade: widget.fade,
            minOpacity: widget.minOpacity,
            duration: widget.duration,
            curve: widget.curve,
            clipBehavior: widget.clipBehavior,
            onComplete: widget.onComplete,
            maintainState: widget.maintainState,
            maintainAnimation: widget.maintainAnimation,
            // child: widget.sizingBuilder(context, CommentsStackWidget: widget, child: widget.containerBuilder(context, CommentsStackWidget: widget, child: widget.childBuilder(context, CommentsStackWidget: widget, child: widget.child))),
            child: widget.child),
          if (!expandLayers && widget.collapsedChild != null)
            GestureDetector(onTap: () {

              setState(() {
                expandLayers = !expandLayers;
              });
            }, child: widget.collapsedChild!),
          GestureDetector(
              onLongPress: onLongPress,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // print("clicked");
                  if (expandLayers ? onCollapsing() : onExpanding()) {
                    setState(() {
                      expandLayers = !expandLayers;
                    });
                  }
                },
                icon: expandLayers ? expandedIcon : collapsedIcon,
                splashRadius: expandLayers ? expandedIconSplashSize : collapsedIconSplashSize,
                iconSize: expandLayers ? expandedIconSize : collapsedIconSize,
                visualDensity: VisualDensity.compact,
                splashColor: Colors.amberAccent,
              )),
        ]);
  }
}
