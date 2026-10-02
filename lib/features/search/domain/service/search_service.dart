import 'package:flutter/material.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';
import 'package:infocontract/features/search/domain/model/quick_search_item.dart';
import 'package:infocontract/features/search/domain/model/search_aarti_item.dart';

class SearchService {
  SearchService({HomeService? homeService, SharedPref? sharedPref})
      : _homeService = homeService ?? HomeService(),
        _sharedPref = sharedPref ?? locator<SharedPref>();

  final HomeService _homeService;
  final SharedPref _sharedPref;

  static const _durations = {
    'ganesh': '2:21',
    'vitthal': '3:10',
    'durga': '4:05',
    'shiva': '3:42',
  };

  List<SearchAartiItem> getAllAartis() {
    return _homeService.getPopularAartis().map((aarti) {
      return SearchAartiItem(
        aarti: aarti,
        duration: _durations[aarti.id] ?? '3:00',
      );
    }).toList();
  }

  List<QuickSearchItem> getQuickSearchItems() {
    return const [
      QuickSearchItem(
        id: 'ganesh',
        labelKey: 'searchDeityGanesh',
        icon: Icons.spa_rounded,
        background: Color(0xFFFFF0E5),
        foreground: Color(0xFFE86B1A),
      ),
      QuickSearchItem(
        id: 'vitthal',
        labelKey: 'searchDeityVitthal',
        icon: Icons.temple_hindu_rounded,
        background: Color(0xFFFFE8DC),
        foreground: Color(0xFFC45A12),
      ),
      QuickSearchItem(
        id: 'shiva',
        labelKey: 'searchDeityShiva',
        icon: Icons.self_improvement_rounded,
        background: Color(0xFFE8F4FF),
        foreground: Color(0xFF3D7BD9),
      ),
      QuickSearchItem(
        id: 'durga',
        labelKey: 'searchDeityDurga',
        icon: Icons.local_florist_rounded,
        background: Color(0xFFFDE8F0),
        foreground: Color(0xFFD45A8A),
      ),
      QuickSearchItem(
        id: 'sai',
        labelKey: 'searchDeitySai',
        icon: Icons.volunteer_activism_rounded,
        background: Color(0xFFFFF6E0),
        foreground: Color(0xFFE0A100),
      ),
      QuickSearchItem(
        id: 'datta',
        labelKey: 'searchDeityDatta',
        icon: Icons.auto_awesome_rounded,
        background: Color(0xFFE8F6EE),
        foreground: Color(0xFF2E9A57),
      ),
    ];
  }

  List<String> getPopularQueryKeys() {
    return const [
      'searchPopularCollection',
      'searchPopularMorning',
      'searchPopularGanesh',
      'searchPopularShiva',
    ];
  }

  List<String> getRecentSearches() => _sharedPref.recentSearches;

  Future<void> addRecentSearch(String query) =>
      _sharedPref.addRecentSearch(query);

  Future<void> removeRecentSearch(String query) =>
      _sharedPref.removeRecentSearch(query);

  Future<void> clearRecentSearches() => _sharedPref.clearRecentSearches();
}
