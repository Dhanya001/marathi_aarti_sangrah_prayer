enum CrudOperator {
  equals, // $eq
  notEquals, // $ne
  greaterThan, // $gt
  greaterThanOrEqual,   // $gte
  lessThan, // $lt
  contains, // $cont
  notContains, // $excl
  inList, // $in
  notInList, // $notin
  isNull, // $isnull
}

enum SortOrder { asc, desc }

String _operatorToSymbol(CrudOperator op) {
  switch (op) {
    case CrudOperator.equals:
      return r'$eq';
    case CrudOperator.notEquals:
      return r'$ne';
    case CrudOperator.greaterThan:
      return r'$gt';
    case CrudOperator.greaterThanOrEqual:
      return r'$gte';
    case CrudOperator.lessThan:
      return r'$lt';
    case CrudOperator.contains:
      return r'$contL';
    case CrudOperator.notContains:
      return r'$excl';
    case CrudOperator.inList:
      return r'$in';
    case CrudOperator.notInList:
      return r'$notin';
    case CrudOperator.isNull:
      return r'$isnull';
  }
}

/// A utility class for building NestJSX CRUD-compatible query parameters.
///
/// Usage Example:
///
/// Using CrudQueryBuilder with Dio:
///
/// import 'package:dio/dio.dart';
/// import 'crud_query_builder.dart'; // your file
///
/// void fetchUsers() async {
/// final query = CrudQueryBuilder()
/// .addField('id')
/// .addField('name')
/// .addSearch('name', CrudOperator.contains, 'john')
/// .addFilter('status', CrudOperator.equals, 'ACTIVE')
/// .addSort('createdAt', SortOrder.desc)
/// .addJoin('profile', select: ['bio', 'avatar'])
/// .setLimit(10)
/// .setPage(1);
///
// ignore: unintended_html_in_doc_comment
/// final params = query.toQueryParams(); // => Map<String, dynamic>
///
/// final dio = Dio();
/// final response = await dio.get(
/// 'https://api.example.com/users',
/// queryParameters: params,
/// );
///
/// print(response.data);
/// }
class CrudQueryBuilder {
  final List<String> _fields = [];

  final List<String> _filter = [];
  final List<String> _or = [];
  final List<String> _sort = [];
  final List<String> _join = [];

  int? _limit;
  int? _offset;
  int? _page;
  int? _cache;
  String? _search;

  /// Add a field to be selected
  CrudQueryBuilder addField(String field) {
    _fields.add(field);
    return this;
  }

  /// Add a search condition (s[])
  CrudQueryBuilder addSearch(String field, CrudOperator op, dynamic value) {
    _search = '$field||${_operatorToSymbol(op)}||$value'; // just one string
    return this;
  }

  /// Add a filter condition (filter[])
  CrudQueryBuilder addFilter(String field, CrudOperator op, dynamic value) {
    _filter.add('$field||${_operatorToSymbol(op)}||$value');
    return this;
  }

  /// Add an OR condition (or[])
  CrudQueryBuilder addOr(String field, CrudOperator op, dynamic value) {
    _or.add('$field||${_operatorToSymbol(op)}||$value');
    return this;
  }

  /// Add sort by field (sort[])
  CrudQueryBuilder addSort(String field, SortOrder order) {
    _sort.add('$field,${order.name.toUpperCase()}');
    return this;
  }

  /// Add relational join (join[])
  CrudQueryBuilder addJoin(String relation, {List<String>? select}) {
    if (select != null && select.isNotEmpty) {
      _join.add('$relation||${select.join(",")}');
    } else {
      _join.add(relation);
    }
    return this;
  }

  /// Set limit
  CrudQueryBuilder setLimit(int value) {
    _limit = value;
    return this;
  }

  /// Set offset
  CrudQueryBuilder setOffset(int value) {
    _offset = value;
    return this;
  }

  /// Set page
  CrudQueryBuilder setPage(int value) {
    _page = value;
    return this;
  }

  /// Set cache (0 = reset cache)
  CrudQueryBuilder setCache(int value) {
    _cache = value;
    return this;
  }

  /// Generate query parameters for Dio/http
  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};

    void addListParam(String key, List<String> values) {
      for (final val in values) {
        params.putIfAbsent(key, () => <String>[]).add(val);
      }
    }

    if (_fields.isNotEmpty) addListParam('fields', _fields);
    if (_search != null) params['s'] = _search;
    if (_filter.isNotEmpty) addListParam('filter', _filter);
    if (_or.isNotEmpty) addListParam('or', _or);
    if (_sort.isNotEmpty) addListParam('sort', _sort);
    if (_join.isNotEmpty) addListParam('join', _join);

    if (_limit != null) params['limit'] = _limit;
    if (_offset != null) params['offset'] = _offset;
    if (_page != null) params['page'] = _page;
    if (_cache != null) params['cache'] = _cache;

    return params;
  }
}
