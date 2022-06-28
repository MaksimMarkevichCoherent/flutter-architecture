import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../networking/api_providers/authentication_provider.dart';
import '../../core/app_manager.dart';
import '../../core/cubit/session_manager/session_cubit.dart';
import '../../core/utils/translate_extension.dart';
import '../app_screen_wrapper.dart';
import '../biometric/cubit/biometric_cubit.dart';
import '../biometric/widgets/biometric_request_dialog.dart';
import '../dialogs/show_select_dialog.dart';
import '../navigation/top_bar.dart';
import 'cubit/pass_code_cubit.dart';
import 'widgets/pass_code_widget.dart';

class PassCodeScreen extends StatelessWidget {
  final PasscodeAction passCodeAction;
  final VoidCallback onPasscodeActionSuccess;

  const PassCodeScreen({
    required this.onPasscodeActionSuccess,
    required this.passCodeAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PassCodeCubit>(
      create: (context) => PassCodeCubit(
        passCodeAction: passCodeAction,
        authentication: context.read<AuthenticationProvider>(),
        session: context.read<SessionCubit>(),
        biometric: context.read<BiometricCubit>(),
      )..getCodeFromBiometricsIfPossible(),
      child: BlocListener<BiometricCubit, BiometricState>(
        listener: (context, state) {
          if (state.status == BiometricStatus.success) {
            onPasscodeActionSuccess();
          }

          if (state.status == BiometricStatus.error) {
            if (state.errorCode == biometricNotAvailableErrorCode) {
              showSelectDialog(
                context,
                titleText: context.tr.error,
                bodyText: state.errorType == BiometricType.face ? tr.errorFaceIdNotEnabled : tr.errorTouchIdNotEnabled,
                cancelButtonText: context.tr.cancel,
                actionButtonText: context.tr.goToAppSettings,
                onCancelPress: () {
                  AutoRouter.of(context).pop();
                  onPasscodeActionSuccess();
                },
                onActionPress: () {
                  AutoRouter.of(context).pop();
                  AppSettings.openSecuritySettings();
                },
              );
            }
            if (state.errorCode == biometricNotEnrolledErrorCode) {
              showSelectDialog(
                context,
                titleText: context.tr.error,
                bodyText:
                    state.errorType == BiometricType.face ? context.tr.errorFaceIdNotSetup : tr.errorTouchIdNotSetup,
                cancelButtonText: context.tr.cancel,
                actionButtonText: context.tr.goToAppSettings,
                onCancelPress: () {
                  AutoRouter.of(context).pop();
                  onPasscodeActionSuccess();
                },
                onActionPress: () {
                  AutoRouter.of(context).pop();
                  AppSettings.openSecuritySettings();
                },
              );
            }
          }
        },
        child: AppScreenWrapper(
          appBar: (passCodeAction == PasscodeAction.check ||
                  passCodeAction == PasscodeAction.changeEnterOldPasscode ||
                  passCodeAction == PasscodeAction.changeCreateNewPasscode ||
                  passCodeAction == PasscodeAction.changeConfirmNewPasscode)
              ? TopBar.back()
              : null,
          disableGoBack: passCodeAction != PasscodeAction.check &&
              passCodeAction != PasscodeAction.changeEnterOldPasscode &&
              passCodeAction != PasscodeAction.changeCreateNewPasscode &&
              passCodeAction != PasscodeAction.changeConfirmNewPasscode,
          child: PassCodeWidget(
            onPasscodeSuccess: (String passcode) async {
              // On successful Sign In or Sign Up a user gets an offer to connect biometrics to passcode
              if (passCodeAction == PasscodeAction.signIn ||
                  passCodeAction == PasscodeAction.signUpCreateNewPasscode ||
                  passCodeAction == PasscodeAction.signUpConfirmNewPasscode) {
                await showBiometricChoosePopup(
                  context: context,
                  passcode: passcode,
                  onSkip: onPasscodeActionSuccess,
                );
              } else {
                // On successful Pass Code check or Unlock the callback is getting invoked
                onPasscodeActionSuccess();
              }
            },
            onPasscodeRestore: (String email) {},
          ),
        ),
      ),
    );
  }

  Future<void> showBiometricChoosePopup({
    required BuildContext context,
    required GestureTapCallback onSkip,
    required String passcode,
  }) async {
    final biometricsMethods = await context.read<BiometricCubit>().getAvailableBiometrics();

    if (biometricsMethods.isEmpty) {
      onSkip();
    } else {
      showMaterialModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (_) => BiometricRequestDialog(
          biometricMethods: biometricsMethods,
          onSkip: onSkip,
          passcode: passcode,
        ),
      );
    }
  }
}
