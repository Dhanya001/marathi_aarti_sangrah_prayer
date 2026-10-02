import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/aarti/domain/model/aarti_content_tab.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class AartiLyricsCard extends StatelessWidget {
  const AartiLyricsCard({
    super.key,
    required this.aarti,
    required this.tab,
  });

  final AartiModel aarti;
  final AartiContentTab tab;

  @override
  Widget build(BuildContext context) {
    final body = switch (tab) {
      AartiContentTab.lyrics => aarti.lyricsFullKey.tr(),
      AartiContentTab.meaning => aarti.meaningKey.tr(),
      AartiContentTab.info => aarti.infoKey.tr(),
    };

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(
        color: AartiColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AartiColors.divider),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: _Flourish()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '|| ${aarti.titleKey.tr()} ||',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AartiColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Expanded(child: _Flourish()),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AartiColors.textPrimary,
              fontSize: 16,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Flourish extends StatelessWidget {
  const _Flourish();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AartiColors.primary.withValues(alpha: 0),
            AartiColors.primary,
            AartiColors.primary.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
