part of 'paginated_list_imp_bloc.dart';

abstract class PaginatedImpState<T> {}

class PaginatedInitial<T> extends PaginatedImpState<T> {}

class PaginatedLoading<T> extends PaginatedImpState<T> {}

class PaginatedLoaded<T> extends PaginatedImpState<T> {
  final List<T> items;
  final bool hasMore;
  final bool isLoadingMore;
  PaginatedLoaded({
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class PaginatedError<T> extends PaginatedImpState<T> {
  final String message;
  PaginatedError(this.message);
}
