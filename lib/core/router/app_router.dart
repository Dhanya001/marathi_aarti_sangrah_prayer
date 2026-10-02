import 'package:auto_route/auto_route.dart';
import 'package:infocontract/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/', initial: true),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: AartiDetailRoute.page, path: '/aarti/:aartiId'),
        AutoRoute(page: NotificationsRoute.page, path: '/notifications'),
        AutoRoute(page: SearchRoute.page, path: '/search'),
      ];
}
