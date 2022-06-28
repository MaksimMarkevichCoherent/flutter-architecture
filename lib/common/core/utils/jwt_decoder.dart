import 'dart:convert';

bool tokenValid(String? token) {
  if (token != null) {
    try {
      final parsedToken = _parseJwt(token);
      final expTime = parsedToken['exp'] as int?;
      return expTime != null && expTime > DateTime.now().millisecondsSinceEpoch / 1000;
    } on Exception catch (_) {
      return false;
    }
  } else {
    return false;
  }
}

String? userIdFromToken(String? token) {
  if (token != null) {
    try {
      final parsedToken = _parseJwt(token);
      return parsedToken['uid'] as String?;
    } on Exception catch (_) {
      return null;
    }
  } else {
    return null;
  }
}

Map<String, dynamic> _parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload) as Map<String, dynamic>;

  return payloadMap;
}

String _decodeBase64(String str) {
  var output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!');
  }

  return utf8.decode(base64Url.decode(output));
}
