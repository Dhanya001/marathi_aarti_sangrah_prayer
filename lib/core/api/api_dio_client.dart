import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:infocontract/core/api/api_result.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';

class ApiDioClient {
  late final Dio _dio;
  final SharedPref? _sharedPref;
  final String? baseUrl;

  SharedPref? get sharedPref {
    if (_sharedPref != null) return _sharedPref;
    try {
      return SharedPref.instance;
    } catch (_) {
      return null;
    }
  }

  static String formatBaseUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }

  ApiDioClient(this._dio, {this.baseUrl, SharedPref? sharedPref})
      : _sharedPref = sharedPref {
    final effectiveBase = formatBaseUrl(baseUrl ?? ApiConstants.baseUrl);
    _dio.options = BaseOptions(
      baseUrl: effectiveBase,
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 25),
      sendTimeout: const Duration(seconds: 25),
      headers: ApiConstants.headers,
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = sharedPref?.accessToken;
          if (token != null && token.isNotEmpty) {
            if (kDebugMode) {
              print(token);
            }
            options.headers['Authorization'] = 'Bearer $token';
          } else {
            // options.headers['Authorization'] =
            //     AppPreferenceKeys.basicAuth;
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // You can add custom logic after the response is received
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Handle errors globally
          return handler.next(e);
        },
      ),
    );
  }

  String normalizePath(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    var cleanPath = path.trim();
    if (cleanPath.startsWith('/api/v1/')) {
      cleanPath = cleanPath.substring('/api/v1/'.length);
    } else if (cleanPath.startsWith('/api/v1')) {
      cleanPath = cleanPath.substring('/api/v1'.length);
    } else if (cleanPath.startsWith('api/v1/')) {
      cleanPath = cleanPath.substring('api/v1/'.length);
    } else if (cleanPath.startsWith('api/v1')) {
      cleanPath = cleanPath.substring('api/v1'.length);
    }

    while (cleanPath.startsWith('/')) {
      cleanPath = cleanPath.substring(1);
    }
    return cleanPath;
  }

  String _normalizePath(String path) => normalizePath(path);

  String _extractErrorMessage(DioException e) {
    if (e.response?.data != null) {
      final data = e.response!.data;
      if (data is Map) {
        if (data['message'] != null) {
          if (data['message'] is List) {
            return (data['message'] as List).join(', ');
          }
          return data['message'].toString();
        }
        if (data['error'] != null) {
          return data['error'].toString();
        }
      } else if (data is String && data.isNotEmpty) {
        return data;
      }
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Connection timed out. Please try again.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'Could not connect to the server. Please check your internet connection.';
    }
    return e.message ?? 'An unexpected error occurred.';
  }

  Future<ApiResult<T>> get<T>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? data,
  }) async {
    try {
      final originalBaseUrl = _dio.options.baseUrl;
      if (baseUrl != null && baseUrl.isNotEmpty) {
        _dio.options.baseUrl = formatBaseUrl(baseUrl);
      }

      final response = await _dio.get<T>(
        _normalizePath(path),
        queryParameters: queryParameters,
        options: options,
        data: data,
      );
      _dio.options.baseUrl = originalBaseUrl;
      return ApiResult.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResult.error(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        _normalizePath(path),
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResult.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResult.error(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ApiResult<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(
        _normalizePath(path),
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return ApiResult.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResult.error(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ApiResult<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        _normalizePath(path),
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResult.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResult.error(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ApiResult<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch<T>(
        _normalizePath(path),
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResult.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResult.error(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response<T>> fetchOptions<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        _normalizePath(path),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch options: ${_extractErrorMessage(e)}');
    }
  }

  Dio get instance => _dio;
}
