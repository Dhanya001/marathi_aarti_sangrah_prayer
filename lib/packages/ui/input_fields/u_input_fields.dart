import 'package:flutter/material.dart';
import 'package:infocontract/packages/theme/app_colors.dart';

class UInputSection extends StatelessWidget {
  final String label;
  final String hintText;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final double borderRadius;
  final bool isRequired;
  final TextEditingController? controller;


  const UInputSection({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.maxLines = 1,
    this.borderRadius = 8,
    this.isRequired = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            if(isRequired)
            Text(
              "*",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        /// Input Field
        TextField(
          maxLines: maxLines,
          onChanged: onChanged,
          controller: controller,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.gray.withValues(alpha: 0.5),
              fontSize: 14,
            ),
            filled: true,
            fillColor: theme.colorScheme.secondaryContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
