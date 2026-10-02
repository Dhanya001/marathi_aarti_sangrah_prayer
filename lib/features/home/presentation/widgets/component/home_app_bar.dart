import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.onMenuTap,
    this.onNotificationTap,
    this.onSearchTap,
  });

  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSearchTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AartiColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onMenuTap,
        icon: const Icon(Icons.menu_rounded, color: AartiColors.textPrimary),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AartiColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'appTitle'.tr(),
                  style: const TextStyle(
                    color: AartiColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'appTagline'.tr(),
                  style: const TextStyle(
                    color: AartiColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onSearchTap,
          icon: const Icon(Icons.search_rounded, color: AartiColors.textPrimary),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AartiColors.textPrimary,
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AartiColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
