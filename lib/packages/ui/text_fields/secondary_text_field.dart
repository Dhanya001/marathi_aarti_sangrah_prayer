import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets/fonts.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class SecondaryTextField extends StatelessWidget {
  final String? hintText;
  final String? iconAssetPath;
  final Widget? prefix;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets contentPadding;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool autofocus;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool? enabled;
  final int? maxLength;
  final AutovalidateMode? autoValidateMode;
  final BoxConstraints? prefixConstraints;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? counterText;
  final Widget? counter;
  final String? prefixText;
  final void Function(String)? onFieldSubmitted;
  final String? suffixText;
  final TextStyle? textStyle;
  final void Function(PointerDownEvent event)? onTapOutside;
  final bool shouldApplyDefaultColorToIcon;
  final bool isDense;
  final EdgeInsetsGeometry? suffixIconPadding;
  final bool isProfileDetailTextField;
  final bool isRequired;
  final TextCapitalization? textCapitalization;
  const SecondaryTextField({
    super.key,
    this.hintText,
    this.iconAssetPath,
    this.borderColor,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.contentPadding = const EdgeInsets.all(20),
    this.hintStyle,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.autofocus = false,
    this.fillColor,
    this.prefix,
    this.inputFormatters,
    this.suffixIcon,
    this.readOnly = false,
    this.enabled,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength = 15,
    this.prefixConstraints,
    this.onTap,
    this.onChanged,
    this.focusNode,
    this.counter,
    this.counterText = '',
    this.prefixText,
    this.suffixText,
    this.onFieldSubmitted,
    this.textStyle,
    this.onTapOutside,
    this.shouldApplyDefaultColorToIcon = true,
    this.isDense = false,
    this.suffixIconPadding,
    this.isProfileDetailTextField = false,
    this.isRequired = false,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    final TextStyle hintStyle =
        this.hintStyle ??
        AppTextStyles.textSm.copyWith(
          color: isDarkTheme
              ? AppColors.primaryDark.withValues(alpha: 0.6)
              : AppColors.primaryText.withValues(alpha: 0.6),  /*Theme.of(
            context,
          ).colorScheme.primary,*/
          fontFamily: FontFamily.outfit,
        );
    return TextFormField(
      focusNode: focusNode,
      onTapOutside: onTapOutside,
      onTap: onTap,
      style:
          textStyle ??
          AppTextStyles.textSmMedium.copyWith(
            color: isDarkTheme
                ? AppColors.primaryDark
                : AppColors.primaryText /*Theme.of(context).colorScheme.primary*/,
          ),
      maxLength: maxLength,
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      autovalidateMode: autoValidateMode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      autocorrect: false,
      decoration: InputDecoration(
        isDense: isDense,
        contentPadding: contentPadding,
        prefixText: prefixText,
        suffixText: suffixText,
        prefixIcon: iconAssetPath != null
            ? Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                child: SvgPicture.asset(
                  iconAssetPath!,
                  width: 24,
                  height: 24,
                  placeholderBuilder: (context) => const Icon(Icons.image),
                  colorFilter: shouldApplyDefaultColorToIcon
                      ? ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)
                      : null,
                ),
              )
            : prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: Padding(
          padding: suffixIconPadding ?? const EdgeInsets.only(left: 18.0, right: 8.0),
          child: suffixIcon,
        ),
        /*label: isRequired
            ? RichText(
                text: TextSpan(
                  text: hintText,
                  style: hintStyle,
                  children: [
                    TextSpan(
                      text: ' *',
                      style: hintStyle.copyWith(color: AppColors.error),
                    ),
                  ],
                ),
              )
            : null,*/
        counter: counter,
        counterText: counterText,
        hintText: hintText,
        hintStyle: hintStyle,
        fillColor:
            fillColor ??
            (isProfileDetailTextField
                ? AppColors.secondary.withAlpha(isDarkTheme ? 51 : 255)
                : isDarkTheme
                ? Theme.of(context).colorScheme.secondaryContainer
                : AppColors.pinFieldBgColor),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!, width: borderWidth),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!, width: borderWidth),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: borderColor == null ? BorderSide.none : const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: borderColor == null ? BorderSide.none : const BorderSide(color: AppColors.error, width: 1.2),
        ),
      ),
    );
  }
}
