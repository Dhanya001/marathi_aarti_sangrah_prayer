import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      cursorColor: AartiColors.primary,
      style: const TextStyle(
        color: AartiColors.textPrimary,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: 'searchHint'.tr(),
        hintStyle: const TextStyle(
          color: AartiColors.textSecondary,
          fontSize: 13,
        ),
        filled: true,
        fillColor: AartiColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AartiColors.textSecondary,
        ),
        suffixIconConstraints: const BoxConstraints(minHeight: 48),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasText)
              IconButton(
                onPressed: onClear,
                icon: const Icon(
                  Icons.close_rounded,
                  color: AartiColors.textSecondary,
                ),
              ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic_none_rounded,
                color: AartiColors.primary,
              ),
            ),
          ],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AartiColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AartiColors.primary, width: 1.4),
        ),
      ),
    );
  }
}
