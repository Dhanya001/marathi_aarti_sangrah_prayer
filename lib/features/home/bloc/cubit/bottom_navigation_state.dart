import 'package:equatable/equatable.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState({
    this.currentTab = BottomNavTab.home,
    this.navItems = const [],
  });

  final BottomNavTab currentTab;
  final List<BottomNavItem> navItems;

  BottomNavigationState copyWith({
    BottomNavTab? currentTab,
    List<BottomNavItem>? navItems,
  }) {
    return BottomNavigationState(
      currentTab: currentTab ?? this.currentTab,
      navItems: navItems ?? this.navItems,
    );
  }

  @override
  List<Object?> get props => [currentTab, navItems];
}
