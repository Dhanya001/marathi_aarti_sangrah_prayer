import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class AartiHeaderCard extends StatelessWidget {
  const AartiHeaderCard({
    super.key,
    required this.aarti,
    required this.onFavoriteTap,
    required this.onShareTap,
  });

  final AartiModel aarti;
  final VoidCallback onFavoriteTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                color: AartiColors.iconBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: aarti.imageUrl != null && aarti.imageUrl!.trim().isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: ApiConstants.resolveMediaUrl(aarti.imageUrl),
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AartiColors.primary,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.temple_hindu_rounded,
                        color: AartiColors.primary,
                        size: 56,
                      ),
                    )
                  : const Icon(
                      Icons.temple_hindu_rounded,
                      color: AartiColors.primary,
                      size: 56,
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aarti.titleKey.tr(),
                  style: const TextStyle(

                    color: AartiColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  aarti.lyricsKey.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AartiColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _MetaRow(
                  icon: Icons.person_outline_rounded,
                  text: aarti.categoryKey.tr(),
                ),
                _MetaRow(
                  icon: Icons.music_note_outlined,
                  text: aarti.languageKey.tr(),
                ),
                _MetaRow(
                  icon: Icons.playlist_play_rounded,
                  text: 'aartiPlayCount'.tr(
                    namedArgs: {'count': _formatCount(aarti.playCount)},
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _ActionChipButton(
                        icon: aarti.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        label: 'aartiFavorite'.tr(),
                        onTap: onFavoriteTap,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionChipButton(
                        icon: Icons.share_outlined,
                        label: 'aartiShare'.tr(),
                        onTap: onShareTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    return NumberFormat('#,###').format(count);
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AartiColors.textSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AartiColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChipButton extends StatelessWidget {
  const _ActionChipButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AartiColors.cardBackground,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AartiColors.divider),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: AartiColors.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: AartiColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
