import 'package:flutter/material.dart';
import 'package:infocontract/features/splash/presentation/widgets/component/splash_colors.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, this.size = 88});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: SplashColors.primary,
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [
          BoxShadow(
            color: SplashColors.primary.withValues(alpha: 0.35),
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.07),
          ),
        ],
      ),
      child: Icon(
        Icons.local_fire_department_rounded,
        color: Colors.white,
        size: size * 0.5,
      ),
    );
  }
}
