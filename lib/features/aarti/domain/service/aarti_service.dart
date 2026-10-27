import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/api/api_result.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';

class AartiService {
  AartiService({
    ApiDioClient? dioClient,
    SharedPref? sharedPref,
  })  : _dioClient = dioClient ?? locator<ApiDioClient>(),
        _sharedPref = sharedPref ?? locator<SharedPref>();

  final ApiDioClient _dioClient;
  final SharedPref _sharedPref;

  /// Fetches aartis from the backend with optional search, category filter, and pagination.
  /// Example: GET /aartis?search=ganpati&categoryId=1&page=1&limit=10
  Future<ApiResult<List<AartiModel>>> getAartis({
    String? search,
    int? categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }
    if (categoryId != null) {
      queryParameters['categoryId'] = categoryId;
    }

    final response = await _dioClient.get(
      ApiConstants.aartis,
      queryParameters: queryParameters,
    );

    if (response.isSuccess && response.data != null) {
      final rawData = response.data;
      List<dynamic> items = [];

      if (rawData is Map && rawData['data'] != null) {
        final nested = rawData['data'];
        if (nested is List) {
          items = nested;
        } else if (nested is Map && nested['items'] is List) {
          items = nested['items'] as List;
        } else if (nested is Map && nested['aartis'] is List) {
          items = nested['aartis'] as List;
        }
      } else if (rawData is List) {
        items = rawData;
      } else if (rawData is Map && rawData['items'] is List) {
        items = rawData['items'] as List;
      }

      final favoriteIds = _sharedPref.favoriteAartiIds;
      final aartis = items.map((json) {
        final model = AartiModel.fromJson(Map<String, dynamic>.from(json as Map));
        return model.copyWith(isFavorite: favoriteIds.contains(model.id));
      }).toList();

      return ApiResult.success(aartis, statusCode: response.statusCode);
    }

    return ApiResult.error(
      response.errorMessage ?? 'Failed to load aartis',
      statusCode: response.statusCode,
    );
  }

  /// Fetches an individual aarti by ID from GET /aartis/:id
  Future<ApiResult<AartiModel>> getAartiById(dynamic id) async {
    final response = await _dioClient.get(ApiConstants.aartiById(id));

    if (response.isSuccess && response.data != null) {
      final rawData = response.data;
      Map<String, dynamic>? itemMap;

      if (rawData is Map && rawData['data'] is Map) {
        itemMap = Map<String, dynamic>.from(rawData['data'] as Map);
      } else if (rawData is Map<String, dynamic>) {
        itemMap = rawData;
      }

      if (itemMap != null) {
        final model = AartiModel.fromJson(itemMap);
        final isFav = _sharedPref.favoriteAartiIds.contains(model.id);
        return ApiResult.success(
          model.copyWith(isFavorite: isFav),
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResult.error(
      response.errorMessage ?? 'Failed to load aarti details',
      statusCode: response.statusCode,
    );
  }

  /// Toggles favorite status in local preferences.
  Future<bool> toggleFavorite(String aartiId) {
    return _sharedPref.toggleFavoriteAarti(aartiId);
  }

  /// Checks if an aarti is favorited.
  bool isFavorite(String aartiId) {
    return _sharedPref.isFavoriteAarti(aartiId);
  }
}

