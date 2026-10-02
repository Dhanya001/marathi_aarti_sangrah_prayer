import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final resolvedImageUrl = ApiConstants.resolveMediaUrl(category.imageUrl);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isSelected
                    ? AartiColors.primary.withValues(alpha: 0.15)
                    : AartiColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AartiColors.primary : Colors.transparent,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AartiColors.shadow,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: resolvedImageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: resolvedImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AartiColors.primary,
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Icon(
                          category.icon,
                          color: AartiColors.primary,
                          size: 28,
                        ),
                      )
                    : Icon(
                        category.icon,
                        color: AartiColors.primary,
                        size: 28,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.labelKey.tr(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected
                    ? AartiColors.primary
                    : AartiColors.textPrimary,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

