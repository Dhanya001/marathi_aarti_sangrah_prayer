import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
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
            child: Icon(
              category.icon,
              color: AartiColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.labelKey.tr(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AartiColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
