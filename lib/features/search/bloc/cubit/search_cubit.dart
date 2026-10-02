import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/search/bloc/cubit/search_state.dart';
import 'package:infocontract/features/search/domain/model/search_aarti_item.dart';
import 'package:infocontract/features/search/domain/service/search_service.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({SearchService? searchService})
      : _searchService = searchService ?? SearchService(),
        super(const SearchState()) {
    load();
  }

  final SearchService _searchService;

  void load() {
    emit(
      state.copyWith(
        quickSearchItems: _searchService.getQuickSearchItems(),
        popularQueryKeys: _searchService.getPopularQueryKeys(),
        popularAartis: _searchService.getAllAartis(),
        recentSearches: _searchService.getRecentSearches(),
      ),
    );
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(query: query, results: _filter(query)));
  }

  Future<void> submitQuery(String query) async {
    final trimmed = query.trim();
    emit(state.copyWith(query: trimmed, results: _filter(trimmed)));
    if (trimmed.isNotEmpty) {
      await _searchService.addRecentSearch(trimmed);
      emit(state.copyWith(recentSearches: _searchService.getRecentSearches()));
    }
  }

  void clearQuery() {
    emit(state.copyWith(query: '', results: const []));
  }

  Future<void> applySuggestion(String query) async {
    await submitQuery(query);
  }

  Future<void> applyQuickSearch(String deityId, String label) async {
    final trimmed = label.trim();
    await _searchService.addRecentSearch(trimmed);
    final byId = state.popularAartis
        .where((item) => item.aarti.id == deityId)
        .toList();
    emit(
      state.copyWith(
        query: trimmed,
        results: byId.isNotEmpty ? byId : _filter(trimmed),
        recentSearches: _searchService.getRecentSearches(),
      ),
    );
  }

  Future<void> removeRecent(String query) async {
    await _searchService.removeRecentSearch(query);
    emit(state.copyWith(recentSearches: _searchService.getRecentSearches()));
  }

  Future<void> clearRecent() async {
    await _searchService.clearRecentSearches();
    emit(state.copyWith(recentSearches: const []));
  }

  List<SearchAartiItem> _filter(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    return state.popularAartis.where((item) {
      final aarti = item.aarti;
      return aarti.id.toLowerCase().contains(q) ||
          aarti.titleKey.tr().toLowerCase().contains(q) ||
          aarti.lyricsKey.tr().toLowerCase().contains(q) ||
          aarti.categoryKey.tr().toLowerCase().contains(q);
    }).toList();
  }
}
