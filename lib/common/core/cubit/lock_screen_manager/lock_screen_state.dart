part of 'lock_screen_cubit.dart';

/// State of the unlock screen.
///
/// [PassCodeScreen] used for unlock functionality.
///
/// [LockScreenStatus.hidden] - session is running, screen isn't visible. It should be set once "unlock" is done.
/// [LockScreenStatus.unlockNeeded] - the app had been paused and user should unlock it to continue session.
enum LockScreenStatus {
  hidden,
  unlockNeeded,
}

class LockScreenState {
  final bool systemPopupShown;
  final LockScreenStatus _status;
  final bool isLaunchUnlock;

  bool get unlockNeeded => _status == LockScreenStatus.unlockNeeded;

  LockScreenState({
    this.systemPopupShown = false,
    LockScreenStatus status = LockScreenStatus.hidden,
    this.isLaunchUnlock = false,
  }) : _status = status;

  LockScreenState copyWith({
    bool? systemPopupShown,
    LockScreenStatus? status,
    bool? isLaunchUnlock,
  }) =>
      LockScreenState(
        systemPopupShown: systemPopupShown ?? this.systemPopupShown,
        status: status ?? _status,
        isLaunchUnlock: isLaunchUnlock ?? false,
      );
}
