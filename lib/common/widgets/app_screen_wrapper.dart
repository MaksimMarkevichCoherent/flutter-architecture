import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'navigation/top_bar.dart';

class AppScreenWrapper extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget child;
  final bool disableGoBack;
  final Widget? floatingActionButton;

  /// Padding instead of the default padding of screen wrapper.
  final EdgeInsets? padding;

  const AppScreenWrapper({
    required this.child,
    Key? key,
    this.appBar,
    this.disableGoBack = false,
    this.padding,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wrapper = Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appBar ?? TopBar.empty(),
      body: SafeArea(
        child: Padding(
          padding: padding ?? EdgeInsets.all(24.w),
          child: child,
        ),
      ),
    );

    if (disableGoBack) {
      return WillPopScope(
        onWillPop: () async => false,
        child: wrapper,
      );
    }

    return wrapper;
  }
}
