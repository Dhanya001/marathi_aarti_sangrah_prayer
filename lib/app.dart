import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/widgets/network_status_banner.dart';
import 'package:infocontract/packages/theme/theme_cubit.dart';

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
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Marathi Aarti Sangrah & Prayer',
          theme: theme,
          builder: (context, child) {
            return NetworkStatusBanner(
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}

