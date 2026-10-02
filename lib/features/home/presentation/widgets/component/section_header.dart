import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.titleKey,
    this.onSeeAllTap,
  });

  final String titleKey;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titleKey.tr(),
              style: const TextStyle(
                color: AartiColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (onSeeAllTap != null)
            GestureDetector(
              onTap: onSeeAllTap,
              child: Row(
                children: [
                  Text(
                    'seeAll'.tr(),
                    style: const TextStyle(
                      color: AartiColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AartiColors.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
