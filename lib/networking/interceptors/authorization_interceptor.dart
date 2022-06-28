import 'package:dio/dio.dart';

import '../../common/core/cubit/session_manager/session_cubit.dart';
import '../api_constants.dart';
import '../environments.dart';
import '../response_models/permanent_auth_response.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  final SessionCubit _session;
  final _RefreshClient _refreshClient = _RefreshClient(Environments.current.baseUrl);

  AuthorizationInterceptor(this._session);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (permanentAuthRequired(options.path)) {
      while (_session.state.accessTokenRefreshInProgress) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }

      if (_session.state.authenticated != null && _session.state.authenticated! && !await _session.accessTokenValid) {
        _session.startTokenRefresh();

        final accessToken = await _session.accessToken;
        final refreshToken = await _session.refreshToken;

        _refreshClient.refreshTokenHeader(accessToken!, refreshToken!);
        try {
          final response =
          await _refreshClient.dio.post<Map<String, dynamic>>(apiConstants.authentication.refreshToken);
          final responseData = PermanentAuthResponse.fromJson(response.data!);

          await _session.updateAuthTokens(
            accessToken: responseData.accessToken,
            refreshToken: responseData.refreshToken,
          );
          options.headers['authorization'] = 'Bearer ${responseData.accessToken}';
        } on DioError catch (error) {
          if (error.response?.statusCode == 401) {
            _session.logout();
          }
        }
      }
      final token = await _session.accessToken;
      options.headers['authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }
}

class _RefreshClient {
  _RefreshClient(String baseUrl) {
    _setupDioClient(baseUrl);
  }

  final Dio dio = Dio();

  final int connectTimeoutInMillis = 30 * 1000;
  final int sentTimeoutInMillis = 30 * 1000;
  final int receiveTimeoutInMillis = 30 * 1000;

  void _setupDioClient(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    _defaultTimeouts();
  }

  void _defaultTimeouts() {
    dio.options.connectTimeout = connectTimeoutInMillis;
    dio.options.sendTimeout = sentTimeoutInMillis;
    dio.options.receiveTimeout = receiveTimeoutInMillis;
  }

  void refreshTokenHeader(String accessToken, String refreshToken) {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.headers['X-Refresh-Token'] = refreshToken;
  }
}
