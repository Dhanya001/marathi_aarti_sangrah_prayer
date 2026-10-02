import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/core/services/localization/language_constants.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AartiColors.background,
      appBar: AppBar(
        backgroundColor: AartiColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'navSettings'.tr(),
          style: const TextStyle(
            color: AartiColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.language_rounded,
                      color: AartiColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'language'.tr(),
                      style: const TextStyle(
                        color: AartiColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'chooseLanguage'.tr(),
                  style: const TextStyle(
                    color: AartiColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                ...LanguageConstants.languages.map((language) {
                  final locale = language['locale'] as Locale;
                  final isSelected = context.locale == locale;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: isSelected
                          ? AartiColors.iconBackground
                          : AartiColors.background,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => context.setLocale(locale),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Text(
                                language['flag'] as String,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  language['text'] as String,
                                  style: TextStyle(
                                    color: AartiColors.textPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AartiColors.primary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
