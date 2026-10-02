part of 'paginated_list_imp_bloc.dart';

abstract class PaginatedImpEvent<T> {}

class FetchPaginatedData<T> extends PaginatedImpEvent<T> {}

class RefreshPaginatedData<T> extends PaginatedImpEvent<T> {
  final bool showLoading;
  RefreshPaginatedData({this.showLoading = false});
}

class SearchPaginatedData<T> extends PaginatedImpEvent<T> {
  final Map<String, dynamic> query;
  SearchPaginatedData(this.query);
}

class UpdateItem<T> extends PaginatedImpEvent<T> {
  final T item;
  UpdateItem(this.item);
}
