import 'package:bloc/bloc.dart';

import '../../../widgets/biometric/cubit/biometric_cubit.dart';

part 'lock_screen_state.dart';

class LockScreenCubit extends Cubit<LockScreenState> {
  final BiometricCubit _biometric;

  LockScreenCubit({required BiometricCubit biometric})
      : _biometric = biometric,
        super(LockScreenState());

  void init() {
    // Authentication with biometric sends app to an inactive state and it may affect screens displayed.
    _biometric.subscribeOnNativeAuthEvent().listen((nativePopupShown) {
      emit(state.copyWith(systemPopupShown: nativePopupShown));
    });
  }

  void setUnlockNeeded({bool? isLaunchUnlock}) {
    emit(
      state.copyWith(
        status: LockScreenStatus.unlockNeeded,
        isLaunchUnlock: isLaunchUnlock,
      ),
    );
  }

  void unlockPassed() {
    emit(state.copyWith(status: LockScreenStatus.hidden));
  }
}
