class ApiResult<T> {
  final T? data;
  final String? errorMessage;
  final int? statusCode;

  ApiResult({this.data, this.errorMessage, this.statusCode});
  factory ApiResult.success(T? data, {int? statusCode}) {
    return ApiResult(data: data, statusCode: statusCode);
  }
  factory ApiResult.error(String? errorMessage, {int? statusCode}) {
    return ApiResult(errorMessage: errorMessage, statusCode: statusCode);
  }

  bool get isSuccess => errorMessage == null && data != null;

  bool get isError => errorMessage != null;

  @override
  String toString() {
    return 'ApiResult(data: $data, errorMessage: $errorMessage, statusCode: $statusCode)';
  }
}
