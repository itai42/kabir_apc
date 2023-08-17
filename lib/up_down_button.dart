import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PressedCallback = void Function({required bool isUpPressed, required bool isDownPressed});

class UpDownButton extends StatelessWidget {
  final bool isUpPressed;
  final bool isDownPressed;
  final IconData upIconFilled;
  final IconData downIconFilled;
  final IconData upIconOutlined;
  final IconData downIconOutlined;
  final Axis childAxis;
  final Axis commentAxis;
  final Axis buttonsAxis;
  final bool hideNonSelected;
  final bool allowCommentEntry;
  final Widget? child;
  final String? upComment;
  final String? downComment;
  final String? unselectedComment;
  final bool clickable;
  final PressedCallback? onUpPressed;
  final PressedCallback? onDownPressed;
  final double iconSize;

  const UpDownButton({
    super.key,
    this.iconSize = 16,
    this.onUpPressed,
    this.onDownPressed,
    this.isUpPressed = false,
    this.upIconFilled = Icons.thumb_up,
    this.downIconFilled = Icons.thumb_down,
    this.upIconOutlined = Icons.thumb_up_outlined,
    this.downIconOutlined = Icons.thumb_down_outlined,
    this.isDownPressed = false,
    this.childAxis = Axis.horizontal,
    this.commentAxis = Axis.horizontal,
    this.buttonsAxis = Axis.horizontal,
    this.hideNonSelected = false,
    this.allowCommentEntry = false,
    this.clickable = true,
    this.upComment,
    this.downComment,
    this.unselectedComment,
    this.child,
  });

  const UpDownButton.upDown({
    super.key,
    this.iconSize = 16,
    this.onUpPressed,
    this.onDownPressed,
    this.isUpPressed = false,
    this.upIconFilled = CupertinoIcons.arrowtriangle_up_fill,
    this.downIconFilled = CupertinoIcons.arrowtriangle_down_fill,
    this.upIconOutlined = CupertinoIcons.arrowtriangle_up,
    this.downIconOutlined = CupertinoIcons.arrowtriangle_down,
    this.isDownPressed = false,
    this.childAxis = Axis.horizontal,
    this.commentAxis = Axis.horizontal,
    this.buttonsAxis = Axis.vertical,
    this.hideNonSelected = true,
    this.allowCommentEntry = false,
    this.clickable = true,
    this.upComment,
    this.downComment,
    this.unselectedComment,
    this.child,
  });

  const UpDownButton.plusMinus({
    super.key,
    this.iconSize = 16,
    this.onUpPressed,
    this.onDownPressed,
    this.isUpPressed = false,
    this.upIconFilled = CupertinoIcons.plus_square_fill,
    this.downIconFilled = CupertinoIcons.minus_square_fill,
    this.upIconOutlined = CupertinoIcons.plus_square,
    this.downIconOutlined = CupertinoIcons.minus_square,
    this.isDownPressed = false,
    this.childAxis = Axis.horizontal,
    this.commentAxis = Axis.horizontal,
    this.buttonsAxis = Axis.vertical,
    this.hideNonSelected = true,
    this.allowCommentEntry = false,
    this.clickable = true,
    this.upComment,
    this.downComment,
    this.unselectedComment,
    this.child,
  });

  IconData get upIcon => isUpPressed ? upIconFilled : upIconOutlined;

  IconData get downIcon => isDownPressed ? downIconFilled : downIconOutlined;

  String? get comment => (!isUpPressed && !isDownPressed) ? unselectedComment : ((isUpPressed ? upComment : null) ?? (isDownPressed ? downComment : null));

  @override
  Widget build(BuildContext context) {
    final arrowsWidget = Flex(direction: commentAxis, crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Flex(direction: buttonsAxis, crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (!hideNonSelected || isUpPressed || !isDownPressed)
          IconButton(iconSize: iconSize,splashRadius: iconSize/2,
            visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
            icon: Icon(upIcon, size: iconSize),
            padding: EdgeInsets.zero,
            onPressed: () {
              if (!clickable) {
                return;
              }
              if (onUpPressed != null) {
                onUpPressed!(isDownPressed: isDownPressed, isUpPressed: isUpPressed);
              }
            },
          ),
        if (!hideNonSelected || !isUpPressed || isDownPressed)
          IconButton(iconSize: iconSize, splashRadius: iconSize/2,
            visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
            icon: Icon(downIcon, size: iconSize),
            padding: EdgeInsets.zero,
            onPressed: () {
              if (!clickable) {
                return;
              }
              if (onDownPressed != null) {
                onDownPressed!(isDownPressed: isDownPressed, isUpPressed: isUpPressed);
              }
            },
          ),
      ]),

      if (comment != null)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: TextField(
              minLines: 1,
              controller: TextEditingController(text: comment),
              maxLines: 5,
              readOnly: true,
              decoration: const InputDecoration.collapsed(hintText: ''),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
    ]);
    return (child != null) ? Flex(direction: childAxis, crossAxisAlignment: CrossAxisAlignment.start, children: [arrowsWidget, child!]) : arrowsWidget;
  }
}
