import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/common/core/utils/translate_extension.dart';
import '/resources/app_icons.dart';
import '../../../modules/home_module/widgets/navigation_bar_icon.dart';

class AppNavigationBar extends StatelessWidget {
  final int activeIndex;
  final Function(int)? onTap;

  const AppNavigationBar({
    required this.activeIndex,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CupertinoTabBar(
      currentIndex: activeIndex,
      onTap: onTap,
      backgroundColor: colorScheme.background,
      activeColor: colorScheme.primary,
      iconSize: 24.w,
      items: [
        BottomNavigationBarItem(
          label: context.tr.home,
          tooltip: '',
          icon: const NavigationBarIcon(
            svgImagePath: IconsSVG.icHome,
          ),
          activeIcon: NavigationBarIcon(
            svgImagePath: IconsSVG.icHome,
            color: colorScheme.primary,
          ),
        ),
        BottomNavigationBarItem(
          tooltip: '',
          label: context.tr.moveMoney,
          icon: const NavigationBarIcon(
            svgImagePath: IconsSVG.icMoveMoney,
          ),
          activeIcon: NavigationBarIcon(
            svgImagePath: IconsSVG.icMoveMoney,
            color: colorScheme.primary,
          ),
        ),
        BottomNavigationBarItem(
          label: context.tr.operators,
          tooltip: '',
          icon: const NavigationBarIcon(
            svgImagePath: IconsSVG.icOperators,
          ),
          activeIcon: NavigationBarIcon(
            svgImagePath: IconsSVG.icOperators,
            color: colorScheme.primary,
          ),
        ),
        BottomNavigationBarItem(
          tooltip: '',
          label: context.tr.settings,
          icon: const NavigationBarIcon(
            svgImagePath: IconsSVG.icSettings,
          ),
          activeIcon: NavigationBarIcon(
            svgImagePath: IconsSVG.icSettings,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
