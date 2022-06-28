import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/theme/app_typography.dart';
import '../../../resources/theme/custom_color_scheme.dart';

Future<bool> showCloseAppDialog(
  BuildContext context, {
  required String titleText,
  required String cancelActionText,
  required String actionText,
}) {
  final colorScheme = Theme.of(context).colorScheme;

  final titleWidget = Padding(
    padding: EdgeInsets.fromLTRB(
      16.w,
      8.w,
      16.w,
      16.w,
    ),
    child: Text(
      titleText,
      textAlign: TextAlign.center,
      style: AppTextStyles.m18.copyWith(color: colorScheme.primaryText),
    ),
  );

  final contentWidget = Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Divider(
        thickness: 1,
        height: 0,
        color: colorScheme.border,
      ),
      SizedBox(
        height: 44.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 44.w,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14.w)),
                    ),
                  ),
                  child: Text(
                    cancelActionText,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.m16.copyWith(color: colorScheme.error),
                  ),
                  onPressed: () {
                    context.router.pop(false);
                  },
                ),
              ),
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: colorScheme.border,
            ),
            Expanded(
              child: SizedBox(
                height: 44.w,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(14.w)),
                    ),
                  ),
                  onPressed: SystemNavigator.pop,
                  child: Text(
                    actionText,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.m16.copyWith(color: colorScheme.linkText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  final dialogWidget = AlertDialog(
    contentPadding: EdgeInsets.zero,
    title: titleWidget,
    elevation: 0,
    content: contentWidget,
    backgroundColor: colorScheme.onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.w),
    ),
  );

  final blurFilter = BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: dialogWidget);

  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return blurFilter;
    },
  ).then((value) => value ?? false);
}
