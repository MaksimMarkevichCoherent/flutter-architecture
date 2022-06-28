import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/theme/custom_color_scheme.dart';
import '../../core/cubit/loading_manager/loading_cubit.dart';

class AppButton extends StatelessWidget {
  final String titleText;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? disabledColor;
  final bool isSupportLoading;
  final Color? backgroundColor;

  bool get enabled => onPressed != null;

  const AppButton({
    required this.titleText,
    Key? key,
    this.onPressed,
    this.textColor,
    this.disabledColor,
    this.isSupportLoading = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoadingCubit, LoadingState>(
      buildWhen: (previous, current) => previous != current && isSupportLoading,
      builder: (context, state) {
        return MaterialButton(
          color: backgroundColor ?? theme.colorScheme.primary,
          disabledColor: disabledColor ?? theme.colorScheme.border,
          onPressed: state.status != LoadingStatus.loading ? onPressed : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.w),
          ),
          child: Container(
            height: 48.w,
            alignment: Alignment.center,
            child: state.status == LoadingStatus.loading
                ? SizedBox(
              height: 20.w,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 1.w,
                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                backgroundColor: theme.colorScheme.onPrimary,
              ),
            )
                : Text(
              titleText,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.button!.copyWith(
                color:
                onPressed != null ? (textColor ?? theme.colorScheme.onPrimary) : theme.colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}
