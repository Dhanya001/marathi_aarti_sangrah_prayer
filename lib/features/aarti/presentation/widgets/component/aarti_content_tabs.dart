import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/aarti/domain/model/aarti_content_tab.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class AartiContentTabs extends StatelessWidget {
  const AartiContentTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final AartiContentTab selected;
  final ValueChanged<AartiContentTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _TabItem(
            icon: Icons.menu_book_outlined,
            label: 'aartiTabLyrics'.tr(),
            selected: selected == AartiContentTab.lyrics,
            onTap: () => onChanged(AartiContentTab.lyrics),
          ),
          _TabItem(
            icon: Icons.description_outlined,
            label: 'aartiTabMeaning'.tr(),
            selected: selected == AartiContentTab.meaning,
            onTap: () => onChanged(AartiContentTab.meaning),
          ),
          _TabItem(
            icon: Icons.info_outline_rounded,
            label: 'aartiTabInfo'.tr(),
            selected: selected == AartiContentTab.info,
            onTap: () => onChanged(AartiContentTab.info),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Icon(
              icon,
              color: selected ? AartiColors.primary : AartiColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? AartiColors.primary : AartiColors.textSecondary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: selected ? 48 : 0,
              decoration: BoxDecoration(
                color: AartiColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
