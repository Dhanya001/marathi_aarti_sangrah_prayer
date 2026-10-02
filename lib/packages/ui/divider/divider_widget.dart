import 'package:flutter/material.dart';
import '../../../../../../packages/theme/app_colors.dart';

class DividerWidget extends StatelessWidget {
  final double? height;
  const DividerWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.gray.withValues(alpha: 0.1),
      thickness: 1,
      height: height ?? 24,
    );
  }
}
