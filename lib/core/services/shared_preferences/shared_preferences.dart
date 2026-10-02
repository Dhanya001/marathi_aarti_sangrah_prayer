import 'package:infocontract/core/di/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SharedPref {
  late final SharedPreferences _prefs;

  final String _accessToken = 'access_token';
  final String _latKey = 'user_latitude';
  final String _lngKey = 'user_longitude';
  final String _addressKey = 'user_address';
  final String _deviceId = 'device_id';
  final String _deviceToken = 'device_token';
  final String _favoriteAartiIds = 'favorite_aarti_ids';
  final String _recentSearches = 'recent_searches';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPref get instance => locator<SharedPref>();

  // Token
  Future<bool> setAccessToken(String accessToken) async {
    return _prefs.setString(_accessToken, accessToken);
  }

  Future<void> logout() async {
    //await _prefs.remove(_accessToken);
    await _prefs.clear();
  }

  /// Get the access token from the shared preferences.
  String get accessToken => _prefs.getString(_accessToken) ?? '';

  // Location: Save LatLng and Address
  Future<void> saveLocation(LatLng latLng, String address) async {
    await _prefs.setDouble(_latKey, latLng.latitude);
    await _prefs.setDouble(_lngKey, latLng.longitude);
    await _prefs.setString(_addressKey, address);
  }

  /// Get the device id from the shared preferences.
  String get deviceId => _prefs.getString(_deviceId) ?? '';

  /// Set the device id in the shared preferences.
  Future<bool> setDeviceId(String deviceId) async {
    return _prefs.setString(_deviceId, deviceId);
  }

  /// Get the device token from the shared preferences.
  String get deviceToken => _prefs.getString(_deviceToken) ?? '';

  /// Set the device token in the shared preferences.
  Future<bool> setDeviceToken(String deviceToken) async {
    return _prefs.setString(_deviceToken, deviceToken);
  }

  LatLng? get savedLatLng {
    final lat = _prefs.getDouble(_latKey);
    final lng = _prefs.getDouble(_lngKey);
    if (lat != null && lng != null) {
      return LatLng(lat, lng);
    }
    return null;
  }

  String get savedAddress => _prefs.getString(_addressKey) ?? '';

  List<String> get favoriteAartiIds =>
      _prefs.getStringList(_favoriteAartiIds) ?? [];

  Future<bool> setFavoriteAartiIds(List<String> ids) {
    return _prefs.setStringList(_favoriteAartiIds, ids);
  }

  Future<bool> toggleFavoriteAarti(String aartiId) {
    final ids = favoriteAartiIds;
    if (ids.contains(aartiId)) {
      ids.remove(aartiId);
    } else {
      ids.add(aartiId);
    }
    return setFavoriteAartiIds(ids);
  }

  bool isFavoriteAarti(String aartiId) => favoriteAartiIds.contains(aartiId);

  List<String> get recentSearches =>
      _prefs.getStringList(_recentSearches) ?? [];

  Future<bool> setRecentSearches(List<String> searches) {
    return _prefs.setStringList(_recentSearches, searches);
  }

  Future<bool> addRecentSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return Future.value(false);
    final searches = List<String>.from(recentSearches)
      ..removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase());
    searches.insert(0, trimmed);
    if (searches.length > 8) {
      searches.removeRange(8, searches.length);
    }
    return setRecentSearches(searches);
  }

  Future<bool> removeRecentSearch(String query) {
    final searches = List<String>.from(recentSearches)..remove(query);
    return setRecentSearches(searches);
  }

  Future<bool> clearRecentSearches() => setRecentSearches([]);
}
