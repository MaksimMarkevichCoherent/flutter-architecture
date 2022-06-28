import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../resources/theme/app_typography.dart';
import '../../../../resources/theme/custom_color_scheme.dart';
import '../../../core/utils/translate_extension.dart';
import '../../buttons/app_button.dart';
import '../cubit/biometric_cubit.dart';

class BiometricRequestDialog extends StatefulWidget {
  final List<BiometricType> biometricMethods;
  final GestureTapCallback onSkip;
  final String passcode;

  const BiometricRequestDialog({
    required this.biometricMethods,
    required this.onSkip,
    required this.passcode,
    Key? key,
  }) : super(key: key);

  @override
  State<BiometricRequestDialog> createState() => _BiometricRequestDialogState();
}

class _BiometricRequestDialogState extends State<BiometricRequestDialog> {
  @override
  void initState() {
    context.read<BiometricCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final descriptionText = description(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 30.h),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0.w),
            topRight: Radius.circular(30.0.w),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24.w),
            Text(
              context.tr.connectBiometric,
              style: AppTextStyles.b18.copyWith(
                color: colorScheme.primaryText,
              ),
            ),
            SizedBox(height: 12.w),
            if (descriptionText != null)
              Text(
                descriptionText,
                textAlign: TextAlign.center,
                style: AppTextStyles.r14.copyWith(
                  color: colorScheme.secondaryText,
                ),
              ),
            SizedBox(height: 18.w),
            AppButton(
              titleText: context.tr.connect,
              onPressed: () async {
                await context.read<BiometricCubit>().setupBiometric(passcode: widget.passcode);
              },
            ),
            SizedBox(height: 6.w),
            GestureDetector(
              onTap: widget.onSkip,
              child: Container(
                color: Colors.transparent,
                height: 42.w,
                child: Center(
                  child: Text(
                    context.tr.skip,
                    style: AppTextStyles.r15.copyWith(
                      color: colorScheme.linkText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? description(BuildContext context) {
    if (widget.biometricMethods.contains(BiometricType.face) && widget.biometricMethods.contains(BiometricType.fingerprint)) {
      return context.tr.connectFaceOrTouch;
    }
    if (widget.biometricMethods.contains(BiometricType.face)) {
      return context.tr.connectFaceId;
    }
    if (widget.biometricMethods.contains(BiometricType.fingerprint)) {
      return context.tr.connectTouchId;
    }
    return null;
  }
}
