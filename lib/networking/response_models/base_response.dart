import '../app_error.dart';
import '../enums/request_status.dart';
import 'error_response.dart';

class BaseResponse<T> {
  /// Request status shows the result of request.
  /// It's a private field and can only be set at the moment of [BaseResponse] creation.
  final RequestStatus _requestStatus;

  /// This field is needed for empty body responses
  /// to make it possible to set the reason of error manually.
  final String? _dioErrorMessage;

  /// Success response.
  /// Contains response result sent by the backend.
  final T? data;

  /// Error response.
  /// Contains error sent by the backend.
  final ErrorResponse? _error;

  bool get success => _requestStatus == RequestStatus.success;

  /// Error message to display.
  ///
  /// Use this getter to display error message to avoid Exceptions.
  String get errorMessage {
    if (_error != null && _error!.errorCode != null) {
      return getLocalizedErrorFromCode(_error!.errorCode!);
    }
    if (_dioErrorMessage != null) {
      return _dioErrorMessage!;
    }
    return getDefaultError();
  }

  BaseResponse({
    required RequestStatus requestStatus,
    this.data,
    ErrorResponse? error,
    String? dioErrorMessage,
  })  : _requestStatus = requestStatus,
        _error = error,
        _dioErrorMessage = dioErrorMessage;
}
