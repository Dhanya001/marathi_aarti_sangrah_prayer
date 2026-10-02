import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/drawer_menu_item.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class DrawerMenuTile extends StatelessWidget {
  const DrawerMenuTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final DrawerMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: item.isHighlighted
            ? AartiColors.iconBackground
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.isHighlighted
                        ? AartiColors.primary
                        : AartiColors.iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: item.isHighlighted
                        ? Colors.white
                        : AartiColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.titleKey.tr(),
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.subtitleKey != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.subtitleKey!.tr(),
                          style: const TextStyle(
                            color: AartiColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
