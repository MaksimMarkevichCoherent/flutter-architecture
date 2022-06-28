import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarIcon extends StatelessWidget {
  final String svgImagePath;
  final Color? color;

  const NavigationBarIcon({
    required this.svgImagePath,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.w),
      child: SvgPicture.asset(
        svgImagePath,
        color: color,
      ),
    );
  }
}
