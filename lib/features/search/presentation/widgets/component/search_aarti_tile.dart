import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/search/domain/model/search_aarti_item.dart';

class SearchAartiTile extends StatelessWidget {
  const SearchAartiTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final SearchAartiItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final aarti = item.aarti;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AartiColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AartiColors.iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.temple_hindu_rounded,
                    color: AartiColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aarti.titleKey.tr(),
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        aarti.lyricsKey.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AartiColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: AartiColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'searchDuration'.tr(namedArgs: {'time': item.duration}),
                            style: const TextStyle(
                              color: AartiColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
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
