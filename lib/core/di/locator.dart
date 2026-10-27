import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/router/app_router.dart';
import 'package:infocontract/core/services/network/global_error_handler.dart';
import 'package:infocontract/core/services/network/network_connectivity_service.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/core/services/snackbar/snackbar_service.dart';
import 'package:infocontract/features/aarti/domain/service/aarti_service.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';
import 'package:infocontract/features/search/domain/service/search_service.dart';

final locator = GetIt.instance;
final AppRouter appRouter = AppRouter();
final GlobalKey<NavigatorState> navigatorKey = appRouter.navigatorKey;
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> setupLocator() async {
  final dio = Dio();
  SharedPref sharedPref = SharedPref();
  await sharedPref.init();
  locator.registerLazySingleton<SharedPref>(() => sharedPref);

  // Network Connectivity & Global Error handling
  final connectivityService = NetworkConnectivityService();
  await connectivityService.init();
  locator.registerSingleton<NetworkConnectivityService>(connectivityService);

  final globalErrorHandler = GlobalErrorHandler(
    navKey: navigatorKey,
    connectivityService: connectivityService,
  );
  locator.registerSingleton<GlobalErrorHandler>(globalErrorHandler);

  locator.registerLazySingleton(() => ApiDioClient(dio));
  locator.registerLazySingleton(() => SnackbarService(scaffoldMessengerKey));

  // Services
  locator.registerLazySingleton<AartiService>(() => AartiService());
  locator.registerLazySingleton<HomeService>(() => HomeService());
  locator.registerLazySingleton<SearchService>(() => SearchService());
}

