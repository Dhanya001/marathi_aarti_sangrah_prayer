import '../config/environment_config.dart';

class ApiEndpoints {
  // Base URLs & Hosts
  static String get baseUrl => EnvironmentConfig.baseUrl;
  static String get baseHost => EnvironmentConfig.baseHost;

  // Categories
  static const String categories = '/categories';
  static String categoryById(dynamic id) => '/categories/$id';

  // Aartis
  static const String aartis = '/aartis';
  static String aartiById(dynamic id) => '/aartis/$id';

  // Auth / User (if needed)
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/auth/profile';

  // Search
  static const String search = '/search';

  // Standard Headers
  static final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Resolves relative or localhost media URLs to the active baseHost
  static String resolveMediaUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    final trimmed = url.trim();

    const localOrigins = [
      'http://localhost:3000',
      'https://localhost:3000',
      'http://10.0.2.2:3000',
      'https://10.0.2.2:3000',
      'http://127.0.0.1:3000',
      'https://127.0.0.1:3000',
    ];

    for (final origin in localOrigins) {
      if (trimmed.startsWith(origin)) {
        final path = trimmed.substring(origin.length);
        final cleanHost = baseHost.endsWith('/')
            ? baseHost.substring(0, baseHost.length - 1)
            : baseHost;
        final cleanPath = path.startsWith('/') ? path : '/$path';
        return '$cleanHost$cleanPath';
      }
    }

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    final host = baseHost;
    final cleanHost = host.endsWith('/') ? host.substring(0, host.length - 1) : host;
    final cleanPath = trimmed.startsWith('/') ? trimmed : '/$trimmed';
    return '$cleanHost$cleanPath';
  }
}
