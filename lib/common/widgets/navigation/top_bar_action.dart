import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBarAction extends StatelessWidget {
  final GestureTapCallback? onTap;

  final Widget child;

  const TopBarAction({
    required this.child,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        return GestureDetector(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            color: Colors.transparent,
            height: 10.w,
            child: Center(
              child: child,
            ),
          ),
        );
      },
    );
  }
}
