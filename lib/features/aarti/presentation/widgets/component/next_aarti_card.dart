import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class NextAartiCard extends StatelessWidget {
  const NextAartiCard({
    super.key,
    required this.aarti,
    required this.onTap,
  });

  final AartiModel aarti;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: AartiColors.iconBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'aartiNext'.tr(),
                  style: const TextStyle(
                    color: AartiColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AartiColors.cardBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.temple_hindu_rounded,
                    color: AartiColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aarti.titleKey.tr(),
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        aarti.lyricsKey.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AartiColors.textSecondary,
                          fontSize: 11,
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
