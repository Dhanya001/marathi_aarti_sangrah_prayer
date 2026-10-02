import 'dart:io';
import 'package:dio/dio.dart';
import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/snackbar/snackbar_service.dart';

import '../../constants/strings/app_string_constants.dart';

class UploadImageFile {
  final File file;
  final String uploadUrl =
      'https://birla-api.bootsonground.app/common/upload'; // Replace with your actual upload URL
  UploadImageFile({required this.file});
  ApiDioClient apiDioClient = locator<ApiDioClient>();
  Future<String?> upload() async {
    try {
      final response = await apiDioClient.post(
        uploadUrl,
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
        }),
      );
      return response.data;
    } catch (e) {
      SnackbarService.instance.showError("${AppString.somethingWentWrong} $e");
      return null;
    }
  }
}
