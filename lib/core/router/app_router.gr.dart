// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:infocontract/features/aarti/presentation/aartiscreen/aarti_detail_screen.dart'
    as _i1;
import 'package:infocontract/features/home/presentation/homescreen/home_screen.dart'
    as _i2;
import 'package:infocontract/features/notifications/presentation/notificationscreen/notifications_screen.dart'
    as _i3;
import 'package:infocontract/features/search/presentation/searchscreen/search_screen.dart'
    as _i4;
import 'package:infocontract/features/splash/presentation/splashscreen/splash_screen.dart'
    as _i5;

/// generated route for
/// [_i1.AartiDetailScreen]
class AartiDetailRoute extends _i6.PageRouteInfo<AartiDetailRouteArgs> {
  AartiDetailRoute({
    _i7.Key? key,
    required String aartiId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         AartiDetailRoute.name,
         args: AartiDetailRouteArgs(key: key, aartiId: aartiId),
         rawPathParams: {'aartiId': aartiId},
         initialChildren: children,
       );

  static const String name = 'AartiDetailRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<AartiDetailRouteArgs>(
        orElse: () =>
            AartiDetailRouteArgs(aartiId: pathParams.getString('aartiId')),
      );
      return _i1.AartiDetailScreen(key: args.key, aartiId: args.aartiId);
    },
  );
}

class AartiDetailRouteArgs {
  const AartiDetailRouteArgs({this.key, required this.aartiId});

  final _i7.Key? key;

  final String aartiId;

  @override
  String toString() {
    return 'AartiDetailRouteArgs{key: $key, aartiId: $aartiId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AartiDetailRouteArgs) return false;
    return key == other.key && aartiId == other.aartiId;
  }

  @override
  int get hashCode => key.hashCode ^ aartiId.hashCode;
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.NotificationsScreen]
class NotificationsRoute extends _i6.PageRouteInfo<void> {
  const NotificationsRoute({List<_i6.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.NotificationsScreen();
    },
  );
}

/// generated route for
/// [_i4.SearchScreen]
class SearchRoute extends _i6.PageRouteInfo<void> {
  const SearchRoute({List<_i6.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SearchScreen();
    },
  );
}

/// generated route for
/// [_i5.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashScreen();
    },
  );
}
