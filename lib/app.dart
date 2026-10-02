import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/router/app_router.dart';
import 'package:infocontract/packages/theme/theme_cubit.dart';

final _appRouter = AppRouter();

class InfoContract extends StatelessWidget {
  const InfoContract({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp.router(
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Marathi Aarti Sangrah & Prayer',
          theme: theme,
        );
      },
    );
  }
}
