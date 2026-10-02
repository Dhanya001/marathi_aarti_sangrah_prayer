import 'package:flutter/material.dart';

enum UButtonStyleType { outlined, filled }

class UOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final UButtonStyleType type;
  final Color? color;
  final double borderRadius;

  const UOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.type = UButtonStyleType.outlined,
    this.color,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = color ?? theme.colorScheme.primary;

    final bool isFilled = type == UButtonStyleType.filled;

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isFilled ? primary.withValues(alpha: 0.1) : Colors.transparent,
          side: BorderSide(color: primary, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          foregroundColor: isFilled ? primary : primary,
          overlayColor: primary.withValues(alpha: 0.08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(color: isFilled ? primary : primary, size: 18),
                child: icon!,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: isFilled ? Theme.of(context).colorScheme.outlineVariant : primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
