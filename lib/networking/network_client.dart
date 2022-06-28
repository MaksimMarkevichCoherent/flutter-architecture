import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../common/core/cubit/session_manager/session_cubit.dart';
import 'interceptors/authorization_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class NetworkClient {
  final SessionCubit _session;

  NetworkClient({
    required String baseUrl,
    required SessionCubit session,
  }) : _session = session {
    _setupDioClient(baseUrl);
  }

  final Dio dio = Dio();

  final int connectTimeoutInMillis = 30 * 1000;
  final int sentTimeoutInMillis = 30 * 1000;
  final int receiveTimeoutInMillis = 30 * 1000;

  void _setupDioClient(String baseUrl) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (url) {
        return 'PROXY localhost:8888; DIRECT';
      };
      return null;
    };
    dio.options.baseUrl = baseUrl;
    _defaultHeaders();
    _defaultInterceptors();
    _defaultTimeouts();
  }

  void _defaultHeaders() {
    _session.state;
    dio.options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;
  }

  void _defaultInterceptors() {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(AuthorizationInterceptor(_session));
    dio.interceptors.add(ErrorInterceptor());
  }

  void _defaultTimeouts() {
    dio.options.connectTimeout = connectTimeoutInMillis;
    dio.options.sendTimeout = sentTimeoutInMillis;
    dio.options.receiveTimeout = receiveTimeoutInMillis;
  }

  void addHeader({required String headerKey, required String headerValue}) {
    dio.options.headers[headerKey] = headerValue;
  }

  void removeHeader(String headerKey) {
    dio.options.headers.remove(headerKey);
  }

  void clearHeaders() {
    dio.options.headers.clear();
  }
}
