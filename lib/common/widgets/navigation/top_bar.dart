import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/app_icons.dart';
import '../../../resources/theme/app_typography.dart';
import '../../../resources/theme/custom_color_scheme.dart';
import '../../core/utils/translate_extension.dart';
import 'top_bar_action.dart';

class TopBar extends AppBar {
  final Widget? leadingActions;
  final List<TopBarAction>? actionsItems;

  /// Customizable TopBar.
  TopBar({
    Key? key,
    double? elevation,
    Color? backgroundColor,
    Widget? title,
    this.leadingActions,
    this.actionsItems,
  }) : super(
          key: key,
          centerTitle: true,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          elevation: elevation ?? 0,
          backgroundColor: backgroundColor ?? Colors.transparent,
          title: title,
          leading: leadingActions,
          actions: actionsItems,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        );

  /// TopBar with text buttons.
  ///
  /// Text signs on buttons are "chancel" and "save" by default.
  factory TopBar.textButtons({
    required String titleText,
    VoidCallback? onLeftTap,
    VoidCallback? onRightTap,
    String? leftButtonText,
    String? rightButtonText,
    bool hasRightButton = true,
  }) =>
      TopBar(
        title: Builder(
          builder: (context) {
            final colorScheme = Theme.of(context).colorScheme;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onLeftTap ?? context.router.pop,
                    child: Text(
                      leftButtonText ?? context.tr.cancel,
                      style: AppTextStyles.r16.copyWith(color: colorScheme.topBarItem),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      titleText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.b16.copyWith(color: colorScheme.onBackground),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasRightButton)
                    InkWell(
                      onTap: onRightTap ?? context.router.pop,
                      child: Text(
                        rightButtonText ?? context.tr.save,
                        style: AppTextStyles.r16.copyWith(color: colorScheme.linkText),
                      ),
                    )
                  else
                    SizedBox(width: 35.w),
                ],
              ),
            );
          },
        ),
      );

  /// TopBar with arrow back.
  ///
  /// Shows widget [title] or text [titleText] with standard styling.
  factory TopBar.back({
    double? elevation,
    Color? backgroundColor,
    Color? arrowColor,
    Widget? title,
    String? titleText,
    final List<TopBarAction>? actionsItems,
  }) {
    return TopBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      title: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          if (title != null) {
            return title;
          }
          return Text(
            titleText ?? '',
            style: AppTextStyles.b16.copyWith(color: colorScheme.onBackground),
          );
        },
      ),
      leadingActions: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return TopBarAction(
            onTap: () {
              context.router.pop();
            },
            child: SvgPicture.asset(
              IconsSVG.icLeft,
              width: 10.w,
              color: arrowColor ?? colorScheme.icon,
            ),
          );
        },
      ),
      actionsItems: actionsItems,
    );
  }

  /// TopBar with cross.
  ///
  /// Shows widget [title] or text [titleText] with standard styling.
  factory TopBar.close({
    double? elevation,
    Color? backgroundColor,
    Widget? title,
    String? titleText,
    final List<TopBarAction>? actionsItems,
  }) {
    return TopBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      title: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          if (title != null) {
            return title;
          }
          return Text(
            titleText ?? '',
            style: AppTextStyles.b16.copyWith(color: colorScheme.onBackground),
          );
        },
      ),
      leadingActions: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return TopBarAction(
            onTap: () {
              context.router.pop();
            },
            child: Icon(
              Icons.close,
              color: colorScheme.icon,
            ),
          );
        },
      ),
      actionsItems: actionsItems,
    );
  }

  /// TopBar with no leading actions.
  ///
  /// Shows widget [title] or text [titleText] with standard styling.
  factory TopBar.empty({
    double? elevation,
    Color? backgroundColor,
    Widget? title,
    String? titleText,
  }) {
    return TopBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      title: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          if (title != null) {
            return title;
          }
          return Text(
            titleText ?? '',
            style: AppTextStyles.b16.copyWith(color: colorScheme.onBackground),
          );
        },
      ),
    );
  }
}
