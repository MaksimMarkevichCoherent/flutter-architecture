import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/app_icons.dart';
import '../../../../resources/theme/app_typography.dart';
import '../../../../resources/theme/custom_color_scheme.dart';
import '../../../core/cubit/session_manager/session_cubit.dart';
import '../../../core/utils/translate_extension.dart';
import '../../loading/app_loading_box.dart';
import '../cubit/pass_code_cubit.dart';
import 'keyboard.dart';
import 'pass_code_circles.dart';

class PassCodeWidget extends StatelessWidget {
  final Function(String passcode) onPasscodeSuccess;
  final Function(String email)? onPasscodeRestore;

  const PassCodeWidget({
    required this.onPasscodeSuccess,
    this.onPasscodeRestore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<PassCodeCubit, PassCodeState>(
      listener: (context, state) async {
        if (state.passcodeStatus == PasscodeStatus.success) {
          onPasscodeSuccess(state.passcode);
        }

        if (state.passcodeStatus == PasscodeStatus.errorWithTimeout) {
          final date = DateTime.fromMillisecondsSinceEpoch(state.blockedUntil! * 1000);

          // showAlertDialogWithCounter(
          //   context,
          //   title: context.tr.errorEnteringPasscode,
          //   description: context.tr.errorTooManyAttempts,
          //   timeLeft: date.difference(DateTime.now()),
          // );
        }

        if (state.passcodeStatus == PasscodeStatus.error && state.backendError != null) {
          // showAlertDialog(
          //   context: context,
          //   title: context.tr.errorEnteringPasscode,
          //   descriptionText: state.backendError!,
          // );
        }

        if (state.passcodeStatus == PasscodeStatus.success &&
            state.passcodeAction == PasscodeAction.changeConfirmNewPasscode) {
          // showDialogWithIcon(
          //   title: context.tr.success,
          //   description: context.tr.passcodeIsSuccessfullyChanged,
          // );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Column(
                  children: [
                    Text(
                      state.passCodeTitle(context),
                      style: AppTextStyles.r16.copyWith(color: colorScheme.onBackground),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.w),
                    PassCodeCircles(
                      filledCount: state.length,
                      success: state.showSuccessCircles,
                      error: state.showErrorCircles,
                    ),
                  ],
                ),
                Keyboard(
                  onKeyboardTap: context.read<PassCodeCubit>().tapNumber,
                  leftWidget: state.passcodeAction == PasscodeAction.unlock ||
                          state.passcodeAction == PasscodeAction.unlockOnLaunch
                      ? Center(
                          child: Text(
                            context.tr.logout,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.r16.copyWith(color: colorScheme.linkText),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : null,
                  onLeftWidgetTap: context.read<SessionCubit>().logout,
                  rightWidget: state.length > 0
                      ? Center(
                          child: SvgPicture.asset(
                            IconsSVG.icDelete,
                          ),
                        )
                      : null,
                  onRightWidgetTap: context.read<PassCodeCubit>().deleteNumber,
                ),
                if (state.passcodeAction == PasscodeAction.signIn)
                  InkWell(
                    child: Text(
                      context.tr.forgotYourPasscode,
                      style: AppTextStyles.r16.copyWith(color: colorScheme.linkText),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      context.read<PassCodeCubit>().initiatePasscodeRestoration().then((email) {
                        if (email != null && onPasscodeRestore != null) {
                          onPasscodeRestore!(email);
                        }
                      });
                    },
                  )
                else
                  SizedBox(height: 18.w),
              ],
            ),
            if (state.passcodeStatus == PasscodeStatus.loading)
              const Center(
                child: AppLoadingBox(color: Colors.transparent),
              ),
          ],
        );
      },
    );
  }
}
