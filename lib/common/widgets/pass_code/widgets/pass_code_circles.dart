import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resources/theme/custom_color_scheme.dart';

class PassCodeCircles extends StatelessWidget {
  final int count;
  final int filledCount;
  final bool success;
  final bool error;

  const PassCodeCircles({
    Key? key,
    this.count = 4,
    this.filledCount = 0,
    this.success = false,
    this.error = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color circleColor(int i) {
      if (success) {
        return colorScheme.success;
      } else if (error) {
        return colorScheme.error;
      } else {
        return i < filledCount ? colorScheme.primary : colorScheme.border.withOpacity(0.5);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        count,
        (i) => Container(
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : 16.w),
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            color: circleColor(i),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
      ),
    );
  }
}
