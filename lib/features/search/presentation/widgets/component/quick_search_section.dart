import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/search/domain/model/quick_search_item.dart';

class QuickSearchSection extends StatelessWidget {
  const QuickSearchSection({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<QuickSearchItem> items;
  final void Function(QuickSearchItem item) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'searchQuick'.tr(),
          style: const TextStyle(
            color: AartiColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onTap(item),
                child: SizedBox(
                  width: 76,
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: item.background,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(item.icon, color: item.foreground, size: 30),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.labelKey.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
