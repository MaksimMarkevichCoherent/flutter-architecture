import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resources/theme/app_typography.dart';
import '../../../../resources/theme/custom_color_scheme.dart';

typedef KeyboardTapCallback = void Function(String text);

class Keyboard extends StatelessWidget {
  final KeyboardTapCallback onKeyboardTap;
  final Widget? leftWidget;
  final GestureTapCallback? onLeftWidgetTap;
  final Widget? rightWidget;
  final GestureTapCallback? onRightWidgetTap;

  const Keyboard({
    required this.onKeyboardTap,
    this.leftWidget,
    this.onLeftWidgetTap,
    this.onRightWidgetTap,
    this.rightWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: true,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      crossAxisSpacing: 32.w,
      mainAxisSpacing: 16.h,
      crossAxisCount: 3,
      children: <Widget>[
        for (var i = 1; i <= 9; i++)
          KeyboardDigit(
            text: i.toString(),
            onKeyboardTap: onKeyboardTap,
          ),
        if (leftWidget != null && onLeftWidgetTap != null)
          KeyboardControl(
            widget: leftWidget!,
            onWidgetTap: onLeftWidgetTap!,
          )
        else
          const SizedBox(),
        KeyboardDigit(text: '0', onKeyboardTap: onKeyboardTap),
        if (rightWidget != null && onRightWidgetTap != null)
          KeyboardControl(
            onWidgetTap: onRightWidgetTap!,
            widget: rightWidget!,
          )
        else
          const SizedBox(),
      ],
    );
  }
}

@visibleForTesting
class KeyboardControl extends StatelessWidget {
  final GestureTapCallback onWidgetTap;
  final Widget widget;

  const KeyboardControl({
    required this.onWidgetTap,
    required this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: colorScheme.primary,
          splashColor: colorScheme.primary.withOpacity(0.4),
          onTap: onWidgetTap,
          child: widget,
        ),
      ),
    );
  }
}

@visibleForTesting
class KeyboardDigit extends StatelessWidget {
  const KeyboardDigit({
    required this.text,
    required this.onKeyboardTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final KeyboardTapCallback onKeyboardTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: colorScheme.pinpadButton.withOpacity(0.5),
          child: InkWell(
            highlightColor: colorScheme.primary,
            splashColor: colorScheme.primary.withOpacity(0.4),
            onTap: () {
              onKeyboardTap(text);
            },
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.r30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
