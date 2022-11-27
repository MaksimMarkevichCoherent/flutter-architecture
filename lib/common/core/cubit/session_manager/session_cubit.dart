import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../resources/storage_constants.dart';
import '../../../secure_repository.dart';
import '../../utils/jwt_decoder.dart';
import '../../utils/logger.dart';
import '../user_role_manager/user_role.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final ISecureRepository _secureRepository;
  final PublishSubject<void> _logoutEvent$ = PublishSubject<void>();

  /// User id.
  Future<String?> get uid async => userIdFromToken(await accessToken);

  /// Used for accessing 'private' routes.
  Future<String?> get accessToken async => _secureRepository.getFromStorage(StorageConstants.accessTokenKey);

  /// Returns true if [accessToken] haven't expired and can be used for performing requests.
  Future<bool> get accessTokenValid async => tokenValid(await accessToken);

  /// Used for refreshing [accessToken].
  Future<String?> get refreshToken async => _secureRepository.getFromStorage(StorageConstants.refreshTokenKey);

  /// Returns true if [refreshToken] haven't expired and can be used for refreshing [accessToken].
  Future<bool> get refreshTokenValid async => tokenValid(await refreshToken);

  /// Returns 'true' if the session can be restored via [refreshToken] and [accessToken] is presented also.
  Future<bool> get sessionValid async => await accessToken != null && await refreshTokenValid;

  /// [tmpToken] replaces permanent authentication.
  /// Used for accessing 'limited' routes.
  Future<String?> get tmpToken async => _secureRepository.getFromStorage(StorageConstants.tmpTokenKey);

  /// Name of current step (Sign In and Onboarding).
  Future<String?> get challenge async => _secureRepository.getFromStorage(StorageConstants.challengeKey);

  /// Passcode value that's entered anywhere it's needed in case of successful biometric verification.
  Future<String?> get passcode async => _secureRepository.getFromStorage(StorageConstants.passCode);

  /// Selected biometric type during Sign In or Onboarding process.
  Future<String?> get biometricType async => _secureRepository.getFromStorage(StorageConstants.biometricType);

  SessionCubit({required ISecureRepository secureRepository})
      : _secureRepository = secureRepository,
        super(const SessionState());

  Future<void> init() async {
    await _getPackageInfo();

    final accessToken = await this.accessToken;
    final refreshTokenValid = await this.refreshTokenValid;

    if (accessToken != null && refreshTokenValid) {
      emit(state.copyWith(authenticated: true));
    } else {
      logout();
    }
    // Remove splash once the screen is initialized
    FlutterNativeSplash.remove();
  }

  Future<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(version: packageInfo.version, buildNumber: packageInfo.buildNumber));
  }

  void startTokenRefresh() {
    emit(state.copyWith(accessTokenRefreshInProgress: true));
  }

  Future<void> updateAuthTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureRepository.addToStorage(StorageConstants.accessTokenKey, accessToken);
    await _secureRepository.addToStorage(StorageConstants.refreshTokenKey, refreshToken);

    emit(
      state.copyWith(
        accessTokenRefreshInProgress: state.accessTokenRefreshInProgress ? false : null,
      ),
    );
  }

  Future<void> updateTmpToken(String token, String? challenge) async {
    await _secureRepository.addToStorage(StorageConstants.tmpTokenKey, token);

    if (challenge != null) {
      await _secureRepository.addToStorage(StorageConstants.challengeKey, challenge);
    }
  }

  void setAuthenticated() {
    emit(state.copyWith(authenticated: true, loggedInDuringCurrentSession: true));
    _clearTmpAuth();
  }

  Future<void> setBiometricAndPasscode({
    required BiometricType biometricType,
    required String passcode,
  }) async {
    await _secureRepository.addToStorage(StorageConstants.passCode, passcode);
    await _secureRepository.addToStorage(StorageConstants.biometricType, biometricType.toString());
  }

  Future<void> setPasscode({required String passcode}) async {
    await _secureRepository.addToStorage(StorageConstants.passCode, passcode);
  }

  void _clearTmpAuth() {
    _secureRepository.deleteFromStorage(StorageConstants.tmpTokenKey);
  }

  /// Removes user info and logouts the user.
  void logout() {
    logger.i('logout');
    _secureRepository.clearSecureStorage();
    _logoutEvent$.add(null);
    emit(state.copyWith(authenticated: false, loggedInDuringCurrentSession: false));
  }

  PublishSubject<void> subscribeOnLogoutEvent() {
    return _logoutEvent$;
  }

  @override
  Future<void> close() {
    _logoutEvent$.close();
    return super.close();
  }
}
