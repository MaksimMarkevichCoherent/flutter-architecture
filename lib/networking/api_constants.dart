import '../common/core/utils/logger.dart';
import '../resources/customization_config.dart';

_ApiConstants apiConstants = _ApiConstants();

bool permanentAuthRequired(String route) {
  logger.i('Using route: $route');
  final authRequired = !route.contains('/limited/') && !route.contains('/public/');
  logger.i('Permanent auth required: $authRequired');
  return authRequired;
}

class _ApiConstants {
  static final _ApiConstants _instance = _ApiConstants._privateConstructor();

  final _Authentication authentication = _Authentication();

  factory _ApiConstants() {
    return _instance;
  }

  _ApiConstants._privateConstructor();
}

class _Authentication {
  String refreshToken = '';
}
