import 'package:flutter/foundation.dart';

class ApiConstants {
  // Base URLs
  static const String prodBaseUrl = 'https://dev-api.infocontracts.com/api/v1';
  static const String devAndroidEmulatorBaseUrl = 'http://10.0.2.2:3000/api/v1';
  static const String devIosOrWebBaseUrl = 'http://localhost:3000/api/v1';

  static String _customBaseUrl = '';

  /// Allows setting a custom base URL dynamically (e.g. for testing on physical LAN devices).
  static void setCustomBaseUrl(String url) {
    _customBaseUrl = url;
  }

  /// Environment-aware baseUrl:
  /// - Android Emulator: http://10.0.2.2:3000/api/v1
  /// - iOS Simulator / Web / Desktop: http://localhost:3000/api/v1
  /// - Overrideable via [setCustomBaseUrl]
  static String get baseUrl {
    if (_customBaseUrl.isNotEmpty) return _customBaseUrl;
    if (kDebugMode) {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        return devAndroidEmulatorBaseUrl;
      }
      return devIosOrWebBaseUrl;
    }
    return devIosOrWebBaseUrl;
  }

  /// Base host without API path prefix (e.g. http://localhost:3000 or http://10.0.2.2:3000)
  static String get baseHost {
    final current = baseUrl;
    final idx = current.indexOf('/api');
    if (idx != -1) {
      return current.substring(0, idx);
    }
    return current;
  }

  /// Resolves media URLs (audio, image) from the backend.
  /// Handles absolute URLs, relative upload paths (e.g. /uploads/images/...),
  /// and Android emulator localhost substitution.
  static String resolveMediaUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    final trimmed = url.trim();

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android && trimmed.contains('localhost')) {
        return trimmed.replaceFirst('localhost', '10.0.2.2');
      }
      return trimmed;
    }

    final host = baseHost;
    final cleanHost = host.endsWith('/') ? host.substring(0, host.length - 1) : host;
    final cleanPath = trimmed.startsWith('/') ? trimmed : '/$trimmed';
    return '$cleanHost$cleanPath';
  }

  // Endpoints
  static const String categories = '/categories';
  static String categoryById(dynamic id) => '/categories/$id';

  static const String aartis = '/aartis';
  static String aartiById(dynamic id) => '/aartis/$id';

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

