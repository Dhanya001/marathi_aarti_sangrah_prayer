import 'package:flutter/material.dart';
import 'package:infocontract/packages/theme/app_colors.dart';

class UElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon; // ✅ Optional icon after text
  final Color? backgroundColor; // ✅ Optional icon after text
  final Color? textColor;

  const UElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon, // optional
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: textColor ?? AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14
              )
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
