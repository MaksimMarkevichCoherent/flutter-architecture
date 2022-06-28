import 'package:local_auth/local_auth.dart';

extension StringToBiometricType on String {
  BiometricType? get toBiometricType {
    switch (this) {
      case 'BiometricType.face':
        return BiometricType.face;
      case 'BiometricType.fingerprint':
        return BiometricType.fingerprint;
      case 'BiometricType.strong':
        return BiometricType.strong;
      case 'BiometricType.weak':
        return BiometricType.weak;
      case 'BiometricType.iris':
        return BiometricType.iris;
      default:
        return null;
    }
  }
}