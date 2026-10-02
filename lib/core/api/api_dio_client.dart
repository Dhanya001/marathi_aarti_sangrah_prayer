import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:infocontract/core/api/api_result.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';

class ApiDioClient {
  late final Dio _dio;
  final SharedPref sharedPref = SharedPref.instance;
  final String? baseUrl;
  ApiDioClient(this._dio, {this.baseUrl}) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl ?? ApiConstants.baseUrl,

      // connectTimeout: Duration(seconds: 15),
      // receiveTimeout: Duration(seconds: 15),
      headers: ApiConstants.headers,
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (sharedPref.accessToken.isNotEmpty) {
            if (kDebugMode) {
              print(sharedPref.accessToken);
            }
            options.headers['Authorization'] =
                'Bearer ${sharedPref.accessToken}';
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
        _dio.options.baseUrl = baseUrl;
      }

      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        data: data,
      );
      _dio.options.baseUrl = originalBaseUrl;
      return ApiResult.success(response.data);
    } on DioException catch (e) {
      return ApiResult.error(e.message);
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
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResult.success(response.data);
    } on DioException catch (e) {
      return ApiResult.error(e.message);
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
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return ApiResult.success(response.data);
    } on DioException catch (e) {
      return ApiResult.error(e.message);
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
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResult.success(response.data);
    } on DioException catch (e) {
      return ApiResult.error(e.message);
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
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResult.success(response.data);
    } on DioException catch (e) {
      return ApiResult.error(e.message);
    }
  }

  Future<Response<T>> fetchOptions<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch options: ${e.message}');
    }
  }

  Dio get instance => _dio;
}
