import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class MultiAssetLoader extends AssetLoader {
  final List<String> paths;

  MultiAssetLoader(this.paths);

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    final Map<String, dynamic> merged = {};

    for (final path in paths) {
      final assetPath = '$path/${locale.languageCode}-${locale.countryCode}.json';
      try {
        final jsonStr = await rootBundle.loadString(assetPath);
        merged.addAll(json.decode(jsonStr));
      } catch (e) {
        // Skip missing files
        continue;
      }
    }

    return merged;
  }
}

