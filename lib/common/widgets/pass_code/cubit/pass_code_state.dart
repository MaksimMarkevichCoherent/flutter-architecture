part of 'pass_code_cubit.dart';

@immutable
class PassCodeState {
  final PasscodeAction passcodeAction;
  final String passcode;
  final String storedPasscode;
  final bool showSuccessCircles;
  final bool showErrorCircles;
  final PasscodeStatus passcodeStatus;
  final int? blockedUntil;
  final String? backendError;

  const PassCodeState({
    required this.passcodeAction,
    this.passcode = '',
    this.storedPasscode = '',
    this.showSuccessCircles = false,
    this.showErrorCircles = false,
    this.passcodeStatus = PasscodeStatus.pending,
    this.blockedUntil,
    this.backendError,
  });

  bool get singUpInProgress =>
      passcodeAction == PasscodeAction.signUpCreateNewPasscode ||
      passcodeAction == PasscodeAction.signUpConfirmNewPasscode;

  bool get changePasscodeInProgress =>
      passcodeAction == PasscodeAction.changeCreateNewPasscode ||
      passcodeAction == PasscodeAction.changeConfirmNewPasscode;

  int get length => passcode.length;

  String passCodeTitle(BuildContext context) {
    if (showErrorCircles) {
      if (passcodeAction == PasscodeAction.changeConfirmNewPasscode) {
        return context.tr.errorWrongNewPasscode;
      }
      return context.tr.wrongPasscode;
    }
    if (passcodeAction == PasscodeAction.signUpCreateNewPasscode) {
      return context.tr.createNewPasscode;
    }
    if (passcodeAction == PasscodeAction.signUpConfirmNewPasscode) {
      return context.tr.repeatPasscode;
    }
    if (passcodeAction == PasscodeAction.changeEnterOldPasscode) {
      return context.tr.oldPasscode;
    }
    if (passcodeAction == PasscodeAction.changeCreateNewPasscode ||
        passcodeAction == PasscodeAction.restoreCreateNewPasscode) {
      return context.tr.createNewPasscode;
    }
    if (passcodeAction == PasscodeAction.changeConfirmNewPasscode ||
        passcodeAction == PasscodeAction.restoreConfirmNewPasscode) {
      return context.tr.repeatNewPasscode;
    }
    return context.tr.enterYourPasscode;
  }

  PassCodeState copyWith({
    PasscodeAction? passcodeAction,
    String? passcode,
    String? storedPasscode,
    bool? showSuccessCircles,
    bool? showErrorCircles,
    PasscodeStatus? passcodeStatus,
    int? blockedUntil,
    String? backendError,
  }) {
    return PassCodeState(
      passcodeAction: passcodeAction ?? this.passcodeAction,
      passcode: passcode ?? this.passcode,
      storedPasscode: storedPasscode ?? this.storedPasscode,
      showSuccessCircles: showSuccessCircles ?? this.showSuccessCircles,
      showErrorCircles: showErrorCircles ?? this.showErrorCircles,
      passcodeStatus: passcodeStatus ?? this.passcodeStatus,
      blockedUntil: blockedUntil ?? this.blockedUntil,
      backendError: backendError,
    );
  }
}
