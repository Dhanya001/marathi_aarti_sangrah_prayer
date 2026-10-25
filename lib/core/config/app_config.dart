import 'environment_config.dart';

class AppConfig {
  static const String appName = 'Marathi Aarti Sangrah & Prayer';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;
  static const String defaultLocale = 'mr';
  static const String defaultCountryCode = 'IN';

  static Environment get environment => EnvironmentConfig.currentEnvironment;
  static String get apiBaseUrl => EnvironmentConfig.baseUrl;
  static String get apiBaseHost => EnvironmentConfig.baseHost;
}
