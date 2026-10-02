import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/api/api_result.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/packages/ui/list/models/list_base_model.dart';

class PaginatedRepository<T extends ListBaseModel> {
  final String endpoint;
  final T modelFactory;
  final int delayDuration; // seconds
  final bool useBodyParameters;
  final String baseUrl;

  PaginatedRepository({
    required this.endpoint,
    required this.modelFactory,
    this.delayDuration = 1,
    this.useBodyParameters = false,
    this.baseUrl = "",
  });
  final ApiDioClient dio = locator<ApiDioClient>();
  Future<List<T>> fetchData({int page = 1, int limit = 10, Map<String, dynamic>? query}) async {
    final result = await Future.wait([
      // Simulate network delay
      Future.delayed(Duration(seconds: delayDuration)),
      _apiCall(page: page, limit: limit, query: query),
    ]);
    final response = result[1];
    final data = response.data['data'] as List;
    // final sampleObject = response.data['data'][0]; // assuming at least 1 item
    // final data = List.generate(100, (_) => sampleObject);

    return data.map((json) => modelFactory.fromJsonListBase(json) as T).toList();
  }

  Future<ApiResult> _apiCall({int page = 1, int limit = 10, Map<String, dynamic>? query}) async {
    return dio.get(
      endpoint,baseUrl: baseUrl,
      queryParameters: useBodyParameters ? null : {'page': page, 'limit': limit, 'enabled': true, ...?query},

      data: useBodyParameters ? {'page': page, 'limit': limit, 'enabled': true, ...?query} : null,
    );
  }
}
