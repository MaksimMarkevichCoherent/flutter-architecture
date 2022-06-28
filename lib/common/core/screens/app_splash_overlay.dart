import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../resources/theme/custom_color_scheme.dart';

class AppSplashOverlay extends StatefulWidget {
  /// If true - shows blur instead of splash image.
  final bool useBlur;

  const AppSplashOverlay({
    Key? key,
    this.useBlur = false,
  }) : super(key: key);

  @override
  State<AppSplashOverlay> createState() => _AppSplashOverlayState();
}

class _AppSplashOverlayState extends State<AppSplashOverlay> with WidgetsBindingObserver {
  bool shouldBeOverlaid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      shouldBeOverlaid = state == AppLifecycleState.inactive || state == AppLifecycleState.paused;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useBlur) {
      return shouldBeOverlaid
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200.withOpacity(0.5),
              ),
            )
          : const SizedBox();
    } else {
      return shouldBeOverlaid
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.splashBackground,
              child: const Center(
                // TODO(anybody): uncomment when theming is fixed
                // child: Image.asset(
                //   MediaQuery.of(context).platformBrightness == Brightness.light
                //       ? AppImages.splashImage
                //       : AppImages.splashImageDark,
                //   fit: BoxFit.contain,
                //   width: 210.w,
                // ),
                // TODO(anybody): add splash logo
                child: SizedBox(),
                // Image.asset(
                //   AppImages.splashImage,
                //   fit: BoxFit.contain,
                //   width: 210.w,
                // ),
              ),
            )
          : const SizedBox();
    }
  }
}
