part of 'paginated_list_bloc.dart';

abstract class PaginatedState<T> {}

class PaginatedInitial<T> extends PaginatedState<T> {}

class PaginatedLoading<T> extends PaginatedState<T> {}

class PaginatedLoaded<T> extends PaginatedState<T> {
  final List<T> items;
  final bool hasMore;
  final bool isLoadingMore;
  PaginatedLoaded({
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class PaginatedError<T> extends PaginatedState<T> {
  final String message;
  PaginatedError(this.message);
}
