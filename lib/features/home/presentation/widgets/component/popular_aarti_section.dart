import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_list_tile.dart';
import 'package:infocontract/features/home/presentation/widgets/component/section_header.dart';

class PopularAartiSection extends StatelessWidget {
  const PopularAartiSection({
    super.key,
    required this.aartis,
    required this.onFavoriteTap,
    required this.onPlayTap,
    this.onAartiTap,
  });

  final List<AartiModel> aartis;
  final ValueChanged<String> onFavoriteTap;
  final ValueChanged<String> onPlayTap;
  final ValueChanged<String>? onAartiTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          titleKey: 'popularAartis',
          onSeeAllTap: () {},
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: aartis.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final aarti = aartis[index];
            return AartiListTile(
              aarti: aarti,
              onFavoriteTap: () => onFavoriteTap(aarti.id),
              onPlayTap: () => onPlayTap(aarti.id),
              onTap: () => onAartiTap?.call(aarti.id),
            );
          },
        ),
      ],
    );
  }
}
