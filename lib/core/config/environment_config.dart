import 'package:flutter/foundation.dart';

enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static const Environment currentEnvironment =
      kDebugMode ? Environment.dev : Environment.prod;

  // Production Base URL
  static const String prodBaseUrl = 'https://dev-api.infocontracts.com/api/v1/';

  // Development Base URL (Dev Tunnel / Local backend)
  static const String devBaseUrl = 'https://ppmm92rv-3000.inc1.devtunnels.ms/api/v1/';

  // Staging Base URL
  static const String stagingBaseUrl = 'https://staging-api.infocontracts.com/api/v1/';

  static const String _envBaseUrl = String.fromEnvironment('API_URL');
  static String _customBaseUrl = '';

  static void setCustomBaseUrl(String url) {
    _customBaseUrl = url.trim();
  }

  static String get baseUrl {
    if (_customBaseUrl.isNotEmpty) {
      return _normalizeUrl(_customBaseUrl);
    }
    if (_envBaseUrl.isNotEmpty) {
      return _normalizeUrl(_envBaseUrl);
    }
    switch (currentEnvironment) {
      case Environment.dev:
        return _normalizeUrl(devBaseUrl);
      case Environment.staging:
        return _normalizeUrl(stagingBaseUrl);
      case Environment.prod:
        return _normalizeUrl(prodBaseUrl);
    }
  }

  static String get baseHost {
    final current = baseUrl;
    final idx = current.indexOf('/api');
    if (idx != -1) {
      return current.substring(0, idx);
    }
    if (current.endsWith('/')) {
      return current.substring(0, current.length - 1);
    }
    return current;
  }

  static String _normalizeUrl(String url) {
    final trimmed = url.trim();
    return trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }
}
