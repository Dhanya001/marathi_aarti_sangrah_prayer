import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/drawer_menu_item.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/home/presentation/widgets/component/drawer_menu_tile.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.onItemTap,
    HomeService? homeService,
  }) : _homeService = homeService;

  final ValueChanged<DrawerMenuItem> onItemTap;
  final HomeService? _homeService;

  @override
  Widget build(BuildContext context) {
    final items = (_homeService ?? HomeService()).getDrawerItems();
    final width = MediaQuery.sizeOf(context).width * 0.82;

    return Drawer(
      width: width,
      backgroundColor: AartiColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const _DrawerHeader(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return DrawerMenuTile(
                    item: item,
                    onTap: () => onItemTap(item),
                  );
                },
              ),
            ),
            _DrawerFooter(onTap: () {
              onItemTap(
                const DrawerMenuItem(
                  id: DrawerMenuId.dailyAarti,
                  titleKey: 'drawerQuoteTitle',
                  icon: Icons.local_fire_department_rounded,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(24),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFC48A),
              Color(0xFFE86B1A),
              Color(0xFF8B4513),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.wb_incandescent_outlined,
              color: Colors.white70,
              size: 28,
            ),
            const SizedBox(height: 16),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AartiColors.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_fire_department_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'appTitle'.tr(),
              style: const TextStyle(
                color: Color(0xFF3A1E0C),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '।। ${'appTagline'.tr()} ।।',
              style: const TextStyle(
                color: Color(0xFF4A2C17),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Material(
        color: AartiColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AartiColors.divider),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: AartiColors.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'drawerQuoteTitle'.tr(),
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'drawerQuoteSubtitle'.tr(),
                        style: const TextStyle(
                          color: AartiColors.textSecondary,
                          fontSize: 11,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AartiColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
