class PermanentAuthResponse {
  final String accessToken;
  final String refreshToken;

  PermanentAuthResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory PermanentAuthResponse.fromJson(Map<String, dynamic> json) {
    return PermanentAuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  @override
  String toString() => 'PermanentAuthResponse: { accessToken: $accessToken, refreshToken: $refreshToken }';
}
