import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/utils/internet_checker.dart';
import 'package:infocontract/packages/ui/list/models/list_base_model.dart';

import '../../../../core/constants/strings/app_string_constants.dart';
import '../paginated_imp_list_repository.dart';

part 'paginated_list_imp_event.dart';
part 'paginated_list_imp_state.dart';

class PaginatedImpBloc<T extends ListBaseModel>
    extends Bloc<PaginatedImpEvent<T>, PaginatedImpState<T>> {
  final PaginatedRepositoryImp<T> repository;
  final int limit;
  Map<String, dynamic>? query;

  int _currentPage = 1;
  bool _hasMore = true;
  final List<T> _items = [];

  PaginatedImpBloc({required this.repository, this.limit = 10, this.query})
    : super(PaginatedInitial()) {
    on<FetchPaginatedData<T>>(_onFetchData);
    on<RefreshPaginatedData<T>>(_onRefresh);
    on<UpdateItem<T>>(_onUpdateItem);
    on<SearchPaginatedData<T>>(_onSearch);
  }

  bool _isFetching = false;

  Future<void> _onFetchData(FetchPaginatedData<T> event, Emitter emit) async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    // 🔌 INTERNET CHECK (early exit)
    final hasInternet = await InternetChecker.hasInternet();
    if (!hasInternet) {
      emit(PaginatedError<T>(AppString.noInternetConnection));
      _isFetching = false;
      return;
    }

    if (_items.isEmpty && _currentPage == 1) {
      emit(PaginatedLoading<T>());
    } else {
      emit(
        PaginatedLoaded<T>(
          items: List<T>.from(_items),
          hasMore: _hasMore,
          isLoadingMore: true,
        ),
      );
    }

    try {
      final newItems = await repository.fetchData(
        page: _currentPage,
        limit: limit,
        query: query,
      );

      /// Optional: Prevent duplicates
      final uniqueNewItems = newItems.where((newItem) {
        return !_items.any(
          (existingItem) => existingItem.hashCode == newItem.hashCode,
        );
      }).toList();

      _hasMore = uniqueNewItems.length == limit;
      _currentPage++;

      _items.addAll(uniqueNewItems);

      emit(
        PaginatedLoaded<T>(
          items: List<T>.from(_items),
          hasMore: _hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(PaginatedError<T>('Error fetching data: $e'));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onRefresh(RefreshPaginatedData<T> event, Emitter emit) async {
    try {
      _currentPage = 1;
      _isFetching = true;
      _items.clear(); // 🔥 ensure no duplicates
      if (event.showLoading) {
        emit(PaginatedLoading<T>());
      }
      final refreshedItems = await repository.fetchData(
        page: _currentPage,
        limit: limit,
        query: query,
      );

      _hasMore = refreshedItems.length == limit;
      _currentPage++; // ✅ increment for next pagination call

      _items.addAll(refreshedItems);

      emit(
        PaginatedLoaded<T>(
          items: List<T>.from(_items),
          hasMore: _hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(PaginatedError<T>('Refresh failed: $e'));
    } finally {
      _isFetching = false;
    }
  }

  void _onUpdateItem(UpdateItem<T> event, Emitter emit) {
    final index = _items.indexOf(event.item);
    if (index != -1) {
      _items[index] = event.item;
      emit(PaginatedLoaded<T>(items: List.from(_items), hasMore: _hasMore));
    }
  }

  Future<void> _onSearch(SearchPaginatedData<T> event, Emitter emit) async {
    try {
      _currentPage = 1;
      _isFetching = true;
      _items.clear(); // 🔥 ensure no duplicates
      query = event.query;
      emit(PaginatedLoading<T>());
      final refreshedItems = await repository.fetchData(
        page: _currentPage,
        limit: limit,
        query: event.query,
      );

      _hasMore = refreshedItems.length == limit;
      _currentPage++; // ✅ increment for next pagination call

      _items.addAll(refreshedItems);

      emit(
        PaginatedLoaded<T>(
          items: List<T>.from(_items),
          hasMore: _hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(PaginatedError<T>('Refresh failed: $e'));
    } finally {
      _isFetching = false;
    }
  }
}
