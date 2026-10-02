import 'package:flutter/material.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/packages/theme/app_colors.dart';

class SnackbarService {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  SnackbarService(this.scaffoldMessengerKey);



  void showSuccess(String message) {
    _show(message, AppColors.green);
  }

  void showError(String message) {
    _show(message, AppColors.red);
  }
  void showInfo(String message) {
    _show(message, AppColors.blue); // Or AppColors.primary / any theme color
  }
  void _show(String message, Color backgroundColor) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message,style: TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static SnackbarService get instance => locator<SnackbarService>();
}
