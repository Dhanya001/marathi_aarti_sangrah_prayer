part of 'paginated_list_bloc.dart';

abstract class PaginatedEvent<T> {
  const PaginatedEvent();
}

class FetchPaginatedData<T> extends PaginatedEvent<T> {}

class RefreshPaginatedData<T> extends PaginatedEvent<T> {
  final bool showLoading;
  RefreshPaginatedData({this.showLoading = false});
}

class SearchPaginatedData<T> extends PaginatedEvent<T> {
  final bool showLoading;
  final Map<String, dynamic>? query;

  const SearchPaginatedData({
    this.query,
    this.showLoading = true,
  });
}


class UpdateItem<T> extends PaginatedEvent<T> {
  final T item;
  UpdateItem(this.item);
}
