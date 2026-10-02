import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class SuvidhaPage extends StatelessWidget {
  const SuvidhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      ('suvidhaPanchang', Icons.calendar_month_outlined),
      ('suvidhaMantra', Icons.auto_stories_outlined),
      ('suvidhaChalisa', Icons.menu_book_outlined),
      ('suvidhaStotra', Icons.volunteer_activism_outlined),
    ];

    return Scaffold(
      backgroundColor: AartiColors.background,
      appBar: AppBar(
        backgroundColor: AartiColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'navSuvidha'.tr(),
          style: const TextStyle(
            color: AartiColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final (labelKey, icon) = features[index];
          return Container(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AartiColors.iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AartiColors.primary, size: 26),
                ),
                const SizedBox(height: 12),
                Text(
                  labelKey.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AartiColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
