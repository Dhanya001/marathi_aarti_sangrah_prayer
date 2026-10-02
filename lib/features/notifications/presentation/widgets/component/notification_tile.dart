import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/notifications/domain/model/notification_icon_type.dart';
import 'package:infocontract/features/notifications/domain/model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = _iconStyle(notification.iconType);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AartiColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: AartiColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: style.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(style.icon, color: style.foreground, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.titleKey.tr(),
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.descriptionKey.tr(),
                        style: const TextStyle(
                          color: AartiColors.textSecondary,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _timeAgo(notification.createdAt),
                        style: const TextStyle(
                          color: AartiColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE53935),
                          shape: BoxShape.circle,
                        ),
                      )
                    else
                      const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AartiColors.textSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime createdAt) {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inMinutes < 60) {
      return 'notifMinutesAgo'.tr(
        namedArgs: {'count': '${difference.inMinutes.clamp(1, 59)}'},
      );
    }
    if (difference.inHours < 24) {
      return 'notifHoursAgo'.tr(
        namedArgs: {'count': '${difference.inHours}'},
      );
    }
    if (difference.inDays == 1) {
      return 'notifYesterday'.tr();
    }
    if (difference.inDays < 7) {
      return 'notifDaysAgo'.tr(namedArgs: {'count': '${difference.inDays}'});
    }
    return 'notifWeekAgo'.tr();
  }

  _IconStyle _iconStyle(NotificationIconType type) {
    return switch (type) {
      NotificationIconType.diya => const _IconStyle(
          icon: Icons.local_fire_department_rounded,
          background: Color(0xFFFFF0E5),
          foreground: AartiColors.primary,
        ),
      NotificationIconType.lotus => const _IconStyle(
          icon: Icons.spa_rounded,
          background: Color(0xFFFDE8F0),
          foreground: Color(0xFFD45A8A),
        ),
      NotificationIconType.megaphone => const _IconStyle(
          icon: Icons.campaign_rounded,
          background: Color(0xFFE8F6EE),
          foreground: Color(0xFF2E9A57),
        ),
      NotificationIconType.mandala => const _IconStyle(
          icon: Icons.brightness_high_rounded,
          background: Color(0xFFF1E8FA),
          foreground: Color(0xFF7B4BB8),
        ),
      NotificationIconType.heart => const _IconStyle(
          icon: Icons.favorite_rounded,
          background: Color(0xFFE8F1FF),
          foreground: Color(0xFF3D7BD9),
        ),
      NotificationIconType.star => const _IconStyle(
          icon: Icons.star_rounded,
          background: Color(0xFFFFF6E0),
          foreground: Color(0xFFE0A100),
        ),
      NotificationIconType.share => const _IconStyle(
          icon: Icons.share_rounded,
          background: Color(0xFFE8F6EE),
          foreground: Color(0xFF2E9A57),
        ),
    };
  }
}

class _IconStyle {
  const _IconStyle({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
}
