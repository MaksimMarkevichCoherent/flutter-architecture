class ErrorResponse {
  final String? code;
  final String? errorCode;
  final String? errorReason;
  final String? errorType;
  final String? id;
  final String? message;
  final String? timestamp;

  ErrorResponse({
    this.code,
    this.errorCode,
    this.errorReason,
    this.errorType,
    this.id,
    this.message,
    this.timestamp,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'] as String?,
      errorCode: json['errorCode'] as String?,
      errorReason: json['errorReason'] as String?,
      errorType: json['errorType'] as String?,
      id: json['id'] as String?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }
}
