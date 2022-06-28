import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/core/utils/translate_extension.dart';
import '../../resources/app_constants.dart';
import '../widgets/biometric/cubit/biometric_cubit.dart';
import '../widgets/dialogs/show_close_app_dialog.dart';
import '../widgets/pass_code/cubit/pass_code_cubit.dart';
import '../widgets/pass_code/pass_code_screen.dart';
import 'cubit/lock_screen_manager/lock_screen_cubit.dart';
import 'cubit/session_manager/session_cubit.dart';
import 'screens/app_splash_overlay.dart';

class AuthenticatedScreen extends StatelessWidget {
  const AuthenticatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LockScreenCubit>(
      create: (context) => LockScreenCubit(
        biometric: context.read<BiometricCubit>(),
      )..init(),
      child: const _AuthenticatedScreen(),
    );
  }
}

class _AuthenticatedScreen extends StatefulWidget {
  const _AuthenticatedScreen({Key? key}) : super(key: key);

  @override
  State<_AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<_AuthenticatedScreen> {
  /// Timer tracks the time of inactivity.
  Timer? _timer;

  @override
  void initState() {
    if (!context.read<SessionCubit>().state.loggedInDuringCurrentSession) {
      showLockScreenIfPossible(isLaunchUnlock: true);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer!.cancel();
    }
    super.dispose();
  }

  /// Restart timer, that shows Unlock Screen.
  ///
  /// Timer restarts:
  /// 1. Initially, when a user gets authenticated
  /// 2. After each tap on the screen
  /// 3. After each swipe
  /// 4. After each screen unlock
  void restartTimer() {
    // Cancel timer if it's been working already
    if (_timer?.isActive == true) {
      _timer!.cancel();
    }
    // We do not need to track time again in case unlock screen already shown
    if (context.read<LockScreenCubit>().state.unlockNeeded) {
      return;
    }

    _timer = Timer(
      const Duration(minutes: AppConstants.lockScreenTimerMinutes),
      showLockScreenIfPossible,
    );
  }

  Future<void> showLockScreenIfPossible({bool isLaunchUnlock = false}) async {
    // If refresh token is valid and access token != null, lock screen can be shown
    if (await context.read<SessionCubit>().sessionValid) {
      context.read<LockScreenCubit>().setUnlockNeeded(isLaunchUnlock: isLaunchUnlock);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LockScreenCubit, LockScreenState>(
      builder: (context, state) {
        return GestureDetector(
          // "PanDown" (tap/scroll) means activity, so we restart timer after each tap
          onPanDown: (_) {
            restartTimer();
          },
          child: WillPopScope(
            onWillPop: () => showCloseAppDialog(
              context,
              actionText: context.tr.yes,
              cancelActionText: context.tr.no,
              titleText: context.tr.doYouWantToCloseTheApp,
            ),
            child: Stack(
              children: [
                const AutoRouter(),
                if (state.unlockNeeded)
                  PassCodeScreen(
                    passCodeAction: state.isLaunchUnlock ? PasscodeAction.unlockOnLaunch : PasscodeAction.unlock,
                    onPasscodeActionSuccess: () {
                      context.read<LockScreenCubit>().unlockPassed();
                      restartTimer();
                    },
                  ),
                if (!state.systemPopupShown) const AppSplashOverlay(),
              ],
            ),
          ),
        );
      },
    );
  }
}
