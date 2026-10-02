import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/home/bloc/cubit/bottom_navigation_cubit.dart';
import 'package:infocontract/features/home/bloc/cubit/bottom_navigation_state.dart';
import 'package:infocontract/features/home/bloc/cubit/home_cubit.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';
import 'package:infocontract/features/home/domain/model/drawer_menu_item.dart';
import 'package:infocontract/features/home/presentation/homescreen/pages/aartis_page.dart';
import 'package:infocontract/features/home/presentation/homescreen/pages/favorites_page.dart';
import 'package:infocontract/features/home/presentation/homescreen/pages/home_page.dart';
import 'package:infocontract/features/home/presentation/homescreen/pages/settings_page.dart';
import 'package:infocontract/features/home/presentation/homescreen/pages/suvidha_page.dart';
import 'package:infocontract/features/home/presentation/widgets/component/custom_bottom_nav_bar.dart';
import 'package:infocontract/features/home/presentation/widgets/component/home_drawer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => BottomNavigationCubit()),
      ],
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatefulWidget {
  const _HomeScreenView();

  @override
  State<_HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<_HomeScreenView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onDrawerItemTap(DrawerMenuItem item) {
    Navigator.of(context).pop();
    if (item.tab != null) {
      context.read<BottomNavigationCubit>().changeTab(item.tab!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, navState) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: HomeDrawer(onItemTap: _onDrawerItemTap),
          body: IndexedStack(
            index: _tabIndex(navState.currentTab),
            children: [
              HomePage(onMenuTap: _openDrawer),
              const AartisPage(),
              const SuvidhaPage(),
              const FavoritesPage(),
              const SettingsPage(),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavBar(),
        );
      },
    );
  }

  int _tabIndex(BottomNavTab tab) {
    return switch (tab) {
      BottomNavTab.home => 0,
      BottomNavTab.aartis => 1,
      BottomNavTab.suvidha => 2,
      BottomNavTab.favorites => 3,
      BottomNavTab.settings => 4,
    };
  }
}
