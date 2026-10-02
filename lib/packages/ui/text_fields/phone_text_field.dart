import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';

import '../../theme/app_colors.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffix;
  final String label;
  final String? initialValue;
  final void Function(IntPhoneNumber)? onChangedCommand;
  final void Function(CountryCodeModel)? onCountryChanged;
  final double? borderRadius;
  final FocusNode? focusNode;
  final bool? enabled;
  final String? Function(IntPhoneNumber?)? validator;
  final AutovalidateMode? autoValidateMode;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.suffix,
    this.onChangedCommand,
    this.initialValue,
    required this.label,
    this.borderRadius = 100.0,
    this.focusNode,
    this.onCountryChanged,
    this.enabled,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
  });

  CountryCodeModel get _initialCountry {
    final dialCode = initialValue ?? '+91';
    if (dialCode == '+91') {
      return CountryCodeModel(name: 'India', dial_code: '+91', code: 'IN');
    }
    return CountryCodeModel(
      name: 'United States',
      dial_code: dialCode,
      code: 'US',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    final borderSideColor = isDarkTheme
        ? AppColors.outlineDark.withValues(alpha: 0.1)
        : AppColors.outline.withValues(alpha: 0.3);
    final fillColor = isDarkTheme
        ? AppColors.secondaryTextFieldBackgroundColorDark
        : AppColors.pinFieldBgColor;
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
      fontWeight: FontWeight.w400,
    );
    final fieldTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return InternationalPhoneNumberInput(
      controller: controller,
      inactive: !(enabled ?? true),
      initCountry: _initialCountry,
      betweenPadding: 12,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onInputChanged: (phone) {
        onChangedCommand?.call(phone);
        onCountryChanged?.call(
          CountryCodeModel(
            name: phone.code,
            dial_code: phone.dial_code,
            code: phone.code,
          ),
        );
      },
      validator: validator == null
          ? null
          : (phone) => validator!(phone),
      dialogConfig: DialogConfig(
        backgroundColor: theme.colorScheme.secondary,
        searchBoxBackgroundColor: theme.colorScheme.surface,
        searchBoxIconColor: theme.colorScheme.onSurface,
        selectedItemColor: theme.colorScheme.primary.withValues(alpha: 0.15),
        topBarColor: theme.colorScheme.secondary,
        flatFlag: true,
        textStyle: fieldTextStyle ?? const TextStyle(),
        searchBoxTextStyle: fieldTextStyle ?? const TextStyle(),
        titleStyle: fieldTextStyle?.copyWith(fontWeight: FontWeight.w600) ??
            const TextStyle(fontWeight: FontWeight.w600),
        searchBoxHintStyle: labelStyle ?? const TextStyle(),
        searchHintText: 'Search country',
        title: 'Country Codes',
      ),
      countryConfig: CountryConfig(
        flatFlag: true,
        flagSize: 20,
        textStyle: fieldTextStyle ?? const TextStyle(),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderSideColor),
        ),
      ),
      phoneConfig: PhoneConfig(
        focusNode: focusNode,
        autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
        labelText: label,
        labelStyle: labelStyle,
        hintText: label,
        hintStyle: labelStyle,
        textStyle: fieldTextStyle ?? const TextStyle(),
        radius: borderRadius ?? 12,
        borderWidth: isDarkTheme ? 1 : 1,
        backgroundColor: fillColor,
        focusedColor: AppColors.primary,
        enabledColor: borderSideColor,
        errorColor: AppColors.error,
        popUpErrorText: false,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(color: borderSideColor),
        ),
      ),
    );
  }
}
