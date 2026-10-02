import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class AartiListTile extends StatelessWidget {
  const AartiListTile({
    super.key,
    required this.aarti,
    required this.onFavoriteTap,
    required this.onPlayTap,
    this.onTap,
  });

  final AartiModel aarti;
  final VoidCallback onFavoriteTap;
  final VoidCallback onPlayTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AartiColors.cardBackground,
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
              size: 30,
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
                    fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onPlayTap,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AartiColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          IconButton(
            onPressed: onFavoriteTap,
            icon: Icon(
              aarti.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: aarti.isFavorite
                  ? AartiColors.primary
                  : AartiColors.textSecondary,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AartiColors.textSecondary,
              size: 22,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
