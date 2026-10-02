import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:infocontract/app.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/localization/language_constants.dart';
import 'package:infocontract/core/services/multi_asset_loader/multi_asset_loader.dart';
import 'package:path_provider/path_provider.dart';
import 'core/services/notification_service/notifications_service.dart';
import 'firebase_options.dart';
import 'packages/theme/theme_cubit.dart';
import 'package:timezone/data/latest.dart' as tz;

String darkMapStyle = '';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  remoteMessage = message;
}

RemoteMessage? remoteMessage;

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  tz.initializeTimeZones();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationsService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
      supportedLocales: LanguageConstants.languages.map((lang) => lang['locale'] as Locale).toList(),
      path: 'assets/localization',
      assetLoader: MultiAssetLoader([
        'assets/localization',
      ]),
      fallbackLocale: const Locale('mr', 'IN'),
      startLocale: const Locale('mr', 'IN'),
      saveLocale: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const InfoContract(),
      ),
    ),
  );
}
