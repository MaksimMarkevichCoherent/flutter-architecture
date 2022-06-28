part of 'biometric_cubit.dart';

const biometricNotAvailableErrorCode = 'NotAvailable';
const biometricNotEnrolledErrorCode = 'NotEnrolled';
const biometricLockedOutErrorCode = 'LockedOut';

enum BiometricStatus { pending, success, error }

class BiometricState {
  final BiometricStatus status;
  final String? errorCode;
  final BiometricType? errorType;

  BiometricState({
    this.status = BiometricStatus.pending,
    this.errorCode,
    this.errorType,
  }) : super();

  BiometricState copyWith({
    BiometricStatus? status,
    String? errorCode,
    BiometricType? errorType,
  }) {
    return BiometricState(
      status: status ?? this.status,
      errorCode: errorCode,
      errorType: errorType,
    );
  }
}
