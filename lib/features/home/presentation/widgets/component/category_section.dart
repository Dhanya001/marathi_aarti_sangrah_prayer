import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/category_card.dart';
import 'package:infocontract/features/home/presentation/widgets/component/section_header.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    this.onCategorySelected,
  });

  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final ValueChanged<CategoryModel>? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          titleKey: 'aartiTypes',
          onSeeAllTap: () {},
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategoryId != null &&
                  (category.id == selectedCategoryId.toString() ||
                      int.tryParse(category.id) == selectedCategoryId);

              return CategoryCard(
                category: category,
                isSelected: isSelected,
                onTap: () => onCategorySelected?.call(category),
              );
            },
          ),
        ),
      ],
    );
  }
}

