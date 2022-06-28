import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/theme/custom_color_scheme.dart';

class AppLoadingBox extends StatelessWidget {
  final double? height;
  final Color? color;

  const AppLoadingBox({
    this.height,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: color ?? colorScheme.containerDarkSurface.withOpacity(0.1),
      height: height ?? 52.w,
      child: Center(
        child: SizedBox(
          height: 24.w,
          width: 24.w,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
