import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/features/search/bloc/cubit/search_state.dart';
import 'package:infocontract/features/search/domain/model/search_aarti_item.dart';
import 'package:infocontract/features/search/domain/service/search_service.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({SearchService? searchService})
      : _searchService = searchService ?? locator<SearchService>(),
        super(const SearchState()) {
    load();
  }

  final SearchService _searchService;
  Timer? _debounceTimer;

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

  /// Debounced search query handler
  void onQueryChanged(String query) {
    _debounceTimer?.cancel();
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      emit(state.copyWith(query: '', results: const [], isLoading: false, errorMessage: null));
      return;
    }

    emit(state.copyWith(query: query, isLoading: true));

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _executeSearch(trimmed);
    });
  }

  /// Immediate query submission (e.g. on keyboard submit)
  Future<void> submitQuery(String query) async {
    _debounceTimer?.cancel();
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      emit(state.copyWith(query: '', results: const [], isLoading: false));
      return;
    }

    emit(state.copyWith(query: trimmed, isLoading: true));
    await _searchService.addRecentSearch(trimmed);
    emit(state.copyWith(recentSearches: _searchService.getRecentSearches()));
    await _executeSearch(trimmed);
  }

  Future<void> _executeSearch(String query) async {
    final result = await _searchService.searchAartis(query, page: 1);
    if (isClosed) return;

    if (result.isSuccess && result.data != null) {
      emit(
        state.copyWith(
          results: result.data!,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } else {
      // If API failed or offline, fallback to filtering local cache
      final localFiltered = _filter(query);
      emit(
        state.copyWith(
          results: localFiltered,
          isLoading: false,
          errorMessage: localFiltered.isNotEmpty ? null : result.errorMessage,
        ),
      );
    }
  }

  void clearQuery() {
    _debounceTimer?.cancel();
    emit(state.copyWith(query: '', results: const [], isLoading: false));
  }

  Future<void> applySuggestion(String query) async {
    await submitQuery(query);
  }

  Future<void> applyQuickSearch(String deityId, String label) async {
    final trimmed = label.trim();
    await _searchService.addRecentSearch(trimmed);
    emit(state.copyWith(query: trimmed, isLoading: true, recentSearches: _searchService.getRecentSearches()));
    await _executeSearch(trimmed);
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

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}

