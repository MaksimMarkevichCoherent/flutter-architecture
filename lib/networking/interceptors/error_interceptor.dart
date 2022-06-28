import 'package:dio/dio.dart';

import '../../common/core/utils/error_handler.dart';

const _dioInternetConnectionErrorText = 'SocketException: Failed host lookup';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.message.contains(_dioInternetConnectionErrorText)) {
      final internetConnectionError = _toInternetConnectionError(err);
      handler.next(internetConnectionError);
    } else {
      handler.next(err);
    }
  }

  DioError _toInternetConnectionError(DioError err) {
    return DioError(
      requestOptions: err.requestOptions,
      error: err.error,
      response: Response<Map<String, String>>(
        requestOptions: err.requestOptions,
        data: {'errorCode': 'INTERNET_CONNECTION_ERROR'},
      ),
    );
  }
}
