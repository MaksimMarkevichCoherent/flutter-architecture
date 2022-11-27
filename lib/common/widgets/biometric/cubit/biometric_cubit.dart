import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/types/auth_messages_android.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../resources/storage_constants.dart';
import '../../../core/app_manager.dart';
import '../../../core/cubit/session_manager/session_cubit.dart';
import '../../../core/utils/logger.dart';
import '../../../secure_repository.dart';
import '../enums/biometric_type.dart';

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  final _biometricAuthRequested$ = PublishSubject<bool>();
  final auth = LocalAuthentication();
  final ISecureRepository secureRepository;
  final SessionCubit session;

  BiometricCubit({
    required this.secureRepository,
    required this.session,
  }) : super(BiometricState());

  void init() {
    emit(state.copyWith(status: BiometricStatus.pending));
  }

  Future<List<BiometricType>> getAvailableBiometrics() => auth.getAvailableBiometrics();

  /// Calls for biometrics and sets passCode to SecureStorage
  Future<void> setupBiometric({required String passcode}) async {
    // Cancel the setup if there are no any biometric methods available
    final availableBiometrics = await getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      return;
    }

    BiometricType? biometricType;
    if (availableBiometrics.contains(BiometricType.face)) {
      // Use Face Scan if it's available
      biometricType = BiometricType.face;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      // Use Fingerprint if it's available and Face Scan isn't
      biometricType = BiometricType.fingerprint;
    } else if (availableBiometrics.contains(BiometricType.strong)) {
      biometricType = BiometricType.strong;
    } else if (availableBiometrics.contains(BiometricType.weak)) {
      biometricType = BiometricType.weak;
    }

    // Cancel the setup if the biometric type isn't defined
    // Such case is possible with only [BiometricType.iris] available
    if (biometricType == null) {
      return;
    }

    try {
      final didAuthenticate = await auth.authenticate(
        localizedReason: _localizedReason(biometricType, true),
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (didAuthenticate) {
        await session.setBiometricAndPasscode(biometricType: biometricType, passcode: passcode);
        emit(state.copyWith(status: BiometricStatus.success));
      }
    } on PlatformException catch (e) {
      logger.e(e);
      emit(
        state.copyWith(
          status: BiometricStatus.error,
          errorCode: e.code,
          errorType: biometricType,
        ),
      );
    }
  }

  /// returns passCode if biometrics is passed
  Future<String?> confirmByBiometric() async {
    final biometricMethod = await session.biometricType;
    if (biometricMethod == null) {
      return null;
    }

    final availableBiometrics = await getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      return null;
    }

    BiometricType? biometricType;
    if (biometricMethod.toBiometricType == BiometricType.face && availableBiometrics.contains(BiometricType.face)) {
      // Use Face Scan if it's available
      biometricType = BiometricType.face;
    } else if (biometricMethod.toBiometricType == BiometricType.fingerprint &&
        availableBiometrics.contains(BiometricType.fingerprint)) {
      // Use Fingerprint if it's available and Face Scan isn't
      biometricType = BiometricType.fingerprint;
    } else if (biometricMethod.toBiometricType == BiometricType.strong &&
        availableBiometrics.contains(BiometricType.strong)) {
      biometricType = BiometricType.strong;
    } else if (biometricMethod.toBiometricType == BiometricType.weak &&
        availableBiometrics.contains(BiometricType.weak)) {
      biometricType = BiometricType.weak;
    }
    // Cancel the setup if the biometric type isn't defined
    // Such case is possible with only [BiometricType.iris] available
    if (biometricType == null) {
      return null;
    }

    try {
      _biometricAuthRequested$.add(true);
      final didAuthenticate = await auth.authenticate(
        authMessages: [
          AndroidAuthMessages(
            biometricHint: tr.biometricAndroidHintAlert,
          ),
        ],
        localizedReason: _localizedReason(biometricType, false),
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      _biometricAuthRequested$.add(false);

      if (didAuthenticate) {
        final passCode = await secureRepository.getFromStorage(StorageConstants.passCode);
        return passCode;
      }
    } on Exception catch (e) {
      logger.e(e);
      return null;
    }

    return null;
  }

  PublishSubject<bool> subscribeOnNativeAuthEvent() {
    return _biometricAuthRequested$;
  }

  String _localizedReason(BiometricType type, bool isSetup) {
    if (Platform.isIOS) {
      type == BiometricType.face ? tr.biometricFaceIdAlert : tr.biometricTouchIdAlert;
    }
    if (isSetup) {
      return tr.biometricAndroidRegistrationAlert;
    }
    return tr.biometricAndroidConfirmAlert;
  }

  @override
  Future<void> close() {
    _biometricAuthRequested$.close();
    return super.close();
  }
}
