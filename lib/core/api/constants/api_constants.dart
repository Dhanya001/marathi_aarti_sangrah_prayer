import 'package:flutter/foundation.dart';

class ApiConstants {
  // Base URLs
  // Production Base URL (Keep unchanged)
  static const String prodBaseUrl = 'https://dev-api.infocontracts.com/api/v1/';

  // Active Development Base URL (Microsoft Dev Tunnel)
  static const String devBaseUrl = 'https://ppmm92rv-3000.inc1.devtunnels.ms/api/v1/';

  // Optional compile-time override: flutter build ... --dart-define=API_URL=https://...
  static const String _envBaseUrl = String.fromEnvironment('API_URL');

  static String _customBaseUrl = '';

  /// Allows setting a custom base URL dynamically (e.g. for testing on physical devices).
  static void setCustomBaseUrl(String url) {
    _customBaseUrl = url.trim();
  }

  /// Environment-aware baseUrl (always normalized with a trailing slash):
  /// 1. Dynamic override via [setCustomBaseUrl]
  /// 2. Compile-time override via --dart-define=API_URL=...
  /// 3. In debug / development mode: [devBaseUrl] (Microsoft Dev Tunnel)
  /// 4. In release / production mode: [prodBaseUrl]
  static String get baseUrl {
    String url = prodBaseUrl;
    if (_customBaseUrl.isNotEmpty) {
      url = _customBaseUrl;
    } else if (_envBaseUrl.isNotEmpty) {
      url = _envBaseUrl;
    } else if (kDebugMode) {
      url = devBaseUrl;
    }
    final trimmed = url.trim();
    return trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }

  /// Base host without API path prefix (e.g. https://ppmm92rv-3000.inc1.devtunnels.ms)
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

  /// Resolves media URLs (audio, image) from the backend.
  ///
  /// - If the URL points to a local backend development address (localhost:3000, 10.0.2.2:3000, 127.0.0.1:3000),
  ///   it rewrites that host to the active [baseHost] (e.g. Microsoft Dev Tunnel).
  /// - If the URL is a relative path (e.g. /uploads/images/profile_pic.png), it prepends [baseHost].
  /// - Unrelated external full URLs (e.g. SoundHelix, Cloudinary, AWS S3) are preserved as-is.
  static String resolveMediaUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    final trimmed = url.trim();

    // Local development backend origins that should map to baseHost
    const localOrigins = [
      'http://localhost:3000',
      'https://localhost:3000',
      'http://10.0.2.2:3000',
      'https://10.0.2.2:3000',
      'http://127.0.0.1:3000',
      'https://127.0.0.1:3000',
    ];

    for (final localOrigin in localOrigins) {
      if (trimmed.startsWith(localOrigin)) {
        final path = trimmed.substring(localOrigin.length);
        final cleanHost = baseHost.endsWith('/')
            ? baseHost.substring(0, baseHost.length - 1)
            : baseHost;
        final cleanPath = path.startsWith('/') ? path : '/$path';
        return '$cleanHost$cleanPath';
      }
    }

    // Unrelated external full URLs remain unchanged
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    // Relative upload paths from backend
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

