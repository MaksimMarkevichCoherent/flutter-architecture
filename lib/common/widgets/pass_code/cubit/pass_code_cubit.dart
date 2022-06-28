import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../networking/api_providers/authentication_provider.dart';
import '../../../core/cubit/session_manager/session_cubit.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/translate_extension.dart';
import '../../biometric/cubit/biometric_cubit.dart';

part 'pass_code_state.dart';

/// State of PassCode screen
/// signUp: creating code on sign Up
/// signIp: user is signing in, code already exists, asks user to enable biometrics
/// check: all kinds of checking - unlock, confirm etc
/// change: change passcode flow.
enum PasscodeAction {
  signIn,
  signUpCreateNewPasscode,
  signUpConfirmNewPasscode,
  check,
  unlock,
  unlockOnLaunch,
  changeEnterOldPasscode,
  changeCreateNewPasscode,
  changeConfirmNewPasscode,
  restoreCreateNewPasscode,
  restoreConfirmNewPasscode,
}

/// User's errors and successes on PassCode screen
/// Does relevant action in listener when action is emitted
enum PasscodeStatus {
  pending,
  validating, // Passcode validation in progress
  loading, // Loading data in progress (not related to a passcode validation)
  success,
  error,
  errorWithTimeout,
}

class PassCodeCubit extends Cubit<PassCodeState> {
  final PasscodeAction passCodeAction;
  final AuthenticationProvider _authentication;
  final SessionCubit _session;
  final BiometricCubit _biometric;

  PassCodeCubit({
    required this.passCodeAction,
    required AuthenticationProvider authentication,
    required SessionCubit session,
    required BiometricCubit biometric,
  })  : _authentication = authentication,
        _session = session,
        _biometric = biometric,
        super(PassCodeState(passcodeAction: passCodeAction));

  Future<void> getCodeFromBiometricsIfPossible() async {
    if ((passCodeAction == PasscodeAction.check ||
            passCodeAction == PasscodeAction.unlock ||
            passCodeAction == PasscodeAction.unlockOnLaunch) &&
        await _session.biometricType != null) {
      if (passCodeAction == PasscodeAction.unlockOnLaunch) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 1200));
      }

      final passCode = await _biometric.confirmByBiometric();
      if (passCode?.length == 4) {
        _passcodeConfirmAction(passCode: passCode);
      } else {
        emit(state.copyWith(passcodeStatus: PasscodeStatus.pending));
      }
    }
  }

  void tapNumber(String number) {
    if (state.passcodeStatus == PasscodeStatus.errorWithTimeout) {
      emit(state.copyWith(passcodeStatus: PasscodeStatus.errorWithTimeout, passcode: ''));
      return;
    }
    if (state.passcodeStatus == PasscodeStatus.pending) {
      if (state.length < 4) {
        emit(state.copyWith(passcode: state.passcode + number));
      }
      if (state.length >= 4) {
        _handleEnteredPasscode();
      }
    }
  }

  void _handleEnteredPasscode() {
    switch (state.passcodeAction) {
      case PasscodeAction.signIn:
        _passcodeCheckSignIn();
        break;
      case PasscodeAction.signUpCreateNewPasscode:
        _createNewPasscodeOnSignUp();
        break;
      case PasscodeAction.signUpConfirmNewPasscode:
        _setPasscodeOnSignUp();
        break;
      case PasscodeAction.check:
      case PasscodeAction.unlock:
      case PasscodeAction.changeEnterOldPasscode:
      case PasscodeAction.unlockOnLaunch:
        _passcodeConfirmAction();
        break;
      case PasscodeAction.changeCreateNewPasscode:
        _createNewPasscodeDuringChange();
        break;
      case PasscodeAction.changeConfirmNewPasscode:
        _confirmNewPasscodeDuringChange();
        break;
      case PasscodeAction.restoreCreateNewPasscode:
        _createNewPasscodeDuringRestoration();
        break;
      case PasscodeAction.restoreConfirmNewPasscode:
        _confirmNewPasscodeDuringRestoration();
        break;
      default:
        logger.e('Passcode action not found');
        break;
    }
  }

  void deleteNumber() {
    emit(state.copyWith(passcode: state.passcode.substring(0, state.length - 1)));
  }

  Future<void> _passcodeCheckSignIn() async {
    emit(state.copyWith(passcodeStatus: PasscodeStatus.validating));

    //final event = await _authentication.passcodeCheckSignIn(passcode: state.passcode);

    //if (event.success) {
    if (true) {
      await _showSuccess();
      await _session.setPasscode(passcode: state.passcode);
      emit(state.copyWith(passcodeStatus: PasscodeStatus.success));
    }
  }

  /// Save the first entered passcode during Sign Up and move to the confirmation.
  Future<void> _createNewPasscodeOnSignUp() async {
    await _showSuccess();
    emit(
      state.copyWith(
        passcode: '',
        storedPasscode: state.passcode,
        passcodeAction: PasscodeAction.signUpConfirmNewPasscode,
      ),
    );
  }

  /// Perform setting the passcode for an account.
  ///
  /// On Success - move further
  /// On Error - reset entered passcodes and step back to enter passcode step, show error
  Future<void> _setPasscodeOnSignUp() async {
    emit(state.copyWith(passcodeStatus: PasscodeStatus.validating));

    // final event = await _authentication.setPasscode(
    //   passcode: state.passcode,
    //   repeatedPasscode: state.storedPasscode,
    // );

    if (true) {
      await _showSuccess();
      await _session.setPasscode(passcode: state.passcode);
      emit(state.copyWith(passcodeStatus: PasscodeStatus.success));
    }
  }

  Future<void> _createNewPasscodeDuringChange() async {
    await _showSuccess(milliseconds: 600);
    emit(
      state.copyWith(
        passcode: '',
        storedPasscode: state.passcode,
        passcodeAction: PasscodeAction.changeConfirmNewPasscode,
      ),
    );
  }

  Future<void> _confirmNewPasscodeDuringChange() async {
    if (state.passcode == state.storedPasscode) {
      // final event = await _authentication.passcodeChange(
      //   newPasscode: state.storedPasscode,
      //   repeatedNewPasscode: state.passcode,
      // );

      if (true) {
        await _showSuccess();
        await _session.setPasscode(passcode: state.passcode);
        emit(state.copyWith(passcodeStatus: PasscodeStatus.success, passcode: ''));
      }

      // if (!event.success) {
      //   emit(state.copyWith(backendError: event.errorMessage, passcode: ''));
      // }
    } else {
      await _showError(milliseconds: 1000);
      emit(
        state.copyWith(
          passcode: '',
          storedPasscode: '',
          passcodeAction: PasscodeAction.changeCreateNewPasscode,
        ),
      );
    }
  }

  Future<void> _createNewPasscodeDuringRestoration() async {
    await _showSuccess(milliseconds: 600);
    emit(
      state.copyWith(
        passcode: '',
        storedPasscode: state.passcode,
        passcodeAction: PasscodeAction.restoreConfirmNewPasscode,
      ),
    );
  }

  Future<void> _confirmNewPasscodeDuringRestoration() async {
    if (state.passcode == state.storedPasscode) {
      // final event = await _authentication.updatePasscodeOnRestoration(
      //   passcode: state.storedPasscode,
      //   repeatedPasscode: state.passcode,
      // );

      if (true) {
        await _showSuccess();
        await _session.setPasscode(passcode: state.passcode);
        emit(state.copyWith(passcodeStatus: PasscodeStatus.success, passcode: ''));
      }

      //if (!event.success) {}
    } else {
      await _showError(milliseconds: 1000);
      emit(
        state.copyWith(
          passcode: '',
          storedPasscode: '',
          passcodeAction: PasscodeAction.restoreCreateNewPasscode,
        ),
      );
    }
  }

  Future<void> _passcodeConfirmAction({String? passCode}) async {
    emit(state.copyWith(passcodeStatus: PasscodeStatus.validating));

    //final event = await _authentication.passcodeCheck(passcode: passCode ?? state.passcode);

    if (true) {
      await _showSuccess();
      if (state.passcodeAction == PasscodeAction.changeEnterOldPasscode) {
        emit(
          state.copyWith(
            passcode: '',
            passcodeStatus: PasscodeStatus.pending,
            passcodeAction: PasscodeAction.changeCreateNewPasscode,
          ),
        );
      } else {
        emit(state.copyWith(passcodeStatus: PasscodeStatus.success, passcode: state.passcode));
      }
    }

    //if (!event.success) {}
  }

  Future<String?> initiatePasscodeRestoration() async {
    emit(state.copyWith(passcodeStatus: PasscodeStatus.loading));
    //final event = await _authentication.initiatePasscodeRestoration();
    emit(state.copyWith(passcodeStatus: PasscodeStatus.pending));

    if (false) {
      //return event.data!.obscuredEmail;
    } else {
      emit(
        state.copyWith(
          passcodeStatus: PasscodeStatus.error,
          backendError: "event.errorMessage",
        ),
      );
      emit(state.copyWith(passcodeStatus: PasscodeStatus.pending));
      return null;
    }
  }

  Future<void> _showSuccess({int milliseconds = 200}) async {
    // We don't change passcodeStatus here because we need to reflect success first
    emit(state.copyWith(showSuccessCircles: true));
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
    emit(state.copyWith(showSuccessCircles: false));
  }

  Future<void> _showError({int milliseconds = 800}) async {
    emit(state.copyWith(showErrorCircles: true, passcodeStatus: PasscodeStatus.error));
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
    emit(state.copyWith(showErrorCircles: false, passcodeStatus: PasscodeStatus.pending));
  }
}
