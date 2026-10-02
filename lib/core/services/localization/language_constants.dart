import 'dart:ui';

class LanguageConstants {
  static const List<Map<String, dynamic>> languages = [
    {
      'name': 'Marathi',
      'code': 'mr',
      'countryCode': 'IN',
      'text': 'मराठी (Marathi)',
      'isRTL': false,
      'fileName': 'mr-IN',
      'flag': '🇮🇳',
      'locale': Locale('mr', 'IN'),
    },
    {
      'name': 'Hindi',
      'code': 'hi',
      'countryCode': 'IN',
      'text': 'हिन्दी (Hindi)',
      'isRTL': false,
      'fileName': 'hi-IN',
      'flag': '🇮🇳',
      'locale': Locale('hi', 'IN'),
    },
    {
      'name': 'English',
      'code': 'en',
      'countryCode': 'US',
      'text': 'English',
      'isRTL': false,
      'fileName': 'en-US',
      'flag': '🇺🇸',
      'locale': Locale('en', 'US'),
    },
  ];
}
