import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/home/bloc/cubit/bottom_navigation_state.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit({HomeService? homeService})
      : _homeService = homeService ?? HomeService(),
        super(
          BottomNavigationState(
            navItems: (homeService ?? HomeService()).getBottomNavItems(),
          ),
        );

  final HomeService _homeService;

  void changeTab(BottomNavTab tab) {
    if (state.currentTab != tab) {
      emit(state.copyWith(currentTab: tab));
    }
  }

  void changeTabByIndex(int index) {
    final items = state.navItems.isNotEmpty
        ? state.navItems
        : _homeService.getBottomNavItems();
    if (index >= 0 && index < items.length) {
      changeTab(items[index].tab);
    }
  }
}
