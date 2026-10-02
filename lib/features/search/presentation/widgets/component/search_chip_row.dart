import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class SearchChipRow extends StatelessWidget {
  const SearchChipRow({
    super.key,
    required this.titleKey,
    required this.labels,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingTap,
    this.actionLabelKey,
    this.onActionTap,
  });

  final String titleKey;
  final List<String> labels;
  final ValueChanged<String> onTap;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final ValueChanged<String>? onTrailingTap;
  final String? actionLabelKey;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                titleKey.tr(),
                style: const TextStyle(
                  color: AartiColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (actionLabelKey != null)
              GestureDetector(
                onTap: onActionTap,
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline_rounded,
                      size: 16,
                      color: AartiColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      actionLabelKey!.tr(),
                      style: const TextStyle(
                        color: AartiColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: labels.map((label) {
            return Material(
              color: AartiColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () => onTap(label),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AartiColors.divider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (leadingIcon != null) ...[
                        Icon(
                          leadingIcon,
                          size: 16,
                          color: AartiColors.primary,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        label,
                        style: const TextStyle(
                          color: AartiColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (trailingIcon != null) ...[
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => onTrailingTap?.call(label),
                          child: Icon(
                            trailingIcon,
                            size: 16,
                            color: AartiColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
