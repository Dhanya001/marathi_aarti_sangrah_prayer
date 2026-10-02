import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/home/bloc/cubit/bottom_navigation_cubit.dart';
import 'package:infocontract/features/home/bloc/cubit/bottom_navigation_state.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: AartiColors.cardBackground,
            boxShadow: [
              BoxShadow(
                color: AartiColors.shadow,
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 72,
              child: Row(
                children: state.navItems.map((item) {
                  final isSelected = state.currentTab == item.tab;
                  final isCenter = item.tab == BottomNavTab.suvidha;

                  if (isCenter) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => context
                            .read<BottomNavigationCubit>()
                            .changeTab(item.tab),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(0, -12),
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AartiColors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AartiColors.primary
                                          .withValues(alpha: 0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, -8),
                              child: Text(
                                item.labelKey.tr(),
                                style: TextStyle(
                                  color: isSelected
                                      ? AartiColors.primary
                                      : AartiColors.textSecondary,
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: _NavItem(
                      item: item,
                      isSelected: isSelected,
                      onTap: () => context
                          .read<BottomNavigationCubit>()
                          .changeTab(item.tab),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? item.activeIcon : item.icon,
            color: isSelected ? AartiColors.primary : AartiColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            item.labelKey.tr(),
            style: TextStyle(
              color:
                  isSelected ? AartiColors.primary : AartiColors.textSecondary,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 20 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: AartiColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
