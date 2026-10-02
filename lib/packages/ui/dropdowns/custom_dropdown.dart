import 'package:flutter/material.dart';
import '../../../core/constants/assets/fonts.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../spacers/vertical_spacer.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String hint;
  final String label;
  final ValueChanged<T?> onChanged;
  final Widget? dropDownIcon, prefixIcon;
  final TextStyle? labelStyle;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    required this.label,
    required this.onChanged,
    this.dropDownIcon,
    this.prefixIcon,
    this.labelStyle,
  });

  InputDecoration customInputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    BuildContext? context,
  }) {
    final bool isDarkTheme = Theme.of(context!).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: isDarkTheme
          ? Theme.of(context).colorScheme.secondaryContainer
          : AppColors.pinFieldBgColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
      hintStyle: AppTextStyles.textSm.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontFamily: FontFamily.outfit,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isNotEmpty
            ? Text(
                label,
                style: labelStyle ?? Theme.of(context).textTheme.bodyMedium,
              )
            : const SizedBox(),
        const VSpacer(8),
        Container(
          decoration: BoxDecoration(
            color: isDarkTheme
                ? Theme.of(context).colorScheme.secondaryContainer
                : AppColors.pinFieldBgColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<T>(
              initialValue: value,
              onChanged: onChanged,
              validator: (value) =>
                  value == null ? '{AppString.select} $hint' : null,
              icon:
                  dropDownIcon ??
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              decoration: customInputDecoration(
                context: context,
                hintText: "{AppString.select} $hint",
                prefixIcon: prefixIcon,
              ),
              items: items,
              hint: Text(
                hint,
                style: AppTextStyles.textSmMedium.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: FontFamily.outfit,
                ),
              ),
              style: AppTextStyles.textSmMedium.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: FontFamily.outfit,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
