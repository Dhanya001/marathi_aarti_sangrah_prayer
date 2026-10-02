import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/core/services/snackbar/snackbar_service.dart';

final locator = GetIt.instance;
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> setupLocator() async {
  final dio = Dio();
  SharedPref sharedPref = SharedPref();
  await sharedPref.init();
  locator.registerLazySingleton<SharedPref>(() => sharedPref);
  locator.registerLazySingleton(() => ApiDioClient(dio));
  locator.registerLazySingleton(() => SnackbarService(scaffoldMessengerKey));
}
