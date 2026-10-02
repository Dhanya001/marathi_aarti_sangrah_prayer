import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class PrimaryButton extends StatefulWidget {
  // final VoidCallback onPressed;
  final FutureOr<void> Function() onPressed;
  final String text;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? textColor;
  final bool disable;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.backgroundColor,
    this.textColor,
    this.disable = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  bool _isLoading = false;

  void _onTapDown(_) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(_) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  Future<void> _handlePressed() async {
    if (_isLoading || widget.disable) return;

    final result = widget.onPressed();
    if (result is Future) {
      setState(() => _isLoading = true);
      try {
        await result;
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldDisable = widget.disable || _isLoading;
    return IgnorePointer(
      ignoring: shouldDisable,
      child: GestureDetector(
        onTap: _handlePressed,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 100),
          scale: _scale,
          child: ElevatedButton(
            onPressed: _handlePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: shouldDisable
                  ? const Color(0xFFB0B4C0)
                  : widget.backgroundColor ??
                        Theme.of(context).colorScheme.primary,
              padding: widget.padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              overlayColor: Colors.black,
            ),
            child: _isLoading
                ? const CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                    backgroundColor: Colors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    widget.text,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color:
                          widget.textColor ??
                          Theme.of(context).colorScheme.secondary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
