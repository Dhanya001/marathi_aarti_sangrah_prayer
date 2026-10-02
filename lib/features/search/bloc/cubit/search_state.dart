import 'package:equatable/equatable.dart';
import 'package:infocontract/features/search/domain/model/quick_search_item.dart';
import 'package:infocontract/features/search/domain/model/search_aarti_item.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.results = const [],
    this.recentSearches = const [],
    this.quickSearchItems = const [],
    this.popularQueryKeys = const [],
    this.popularAartis = const [],
  });

  final String query;
  final List<SearchAartiItem> results;
  final List<String> recentSearches;
  final List<QuickSearchItem> quickSearchItems;
  final List<String> popularQueryKeys;
  final List<SearchAartiItem> popularAartis;

  bool get isSearching => query.trim().isNotEmpty;

  SearchState copyWith({
    String? query,
    List<SearchAartiItem>? results,
    List<String>? recentSearches,
    List<QuickSearchItem>? quickSearchItems,
    List<String>? popularQueryKeys,
    List<SearchAartiItem>? popularAartis,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
      quickSearchItems: quickSearchItems ?? this.quickSearchItems,
      popularQueryKeys: popularQueryKeys ?? this.popularQueryKeys,
      popularAartis: popularAartis ?? this.popularAartis,
    );
  }

  @override
  List<Object?> get props => [
        query,
        results,
        recentSearches,
        quickSearchItems,
        popularQueryKeys,
        popularAartis,
      ];
}
