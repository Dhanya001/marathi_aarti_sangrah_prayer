import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/splash/presentation/widgets/component/splash_colors.dart';
import 'package:infocontract/features/splash/presentation/widgets/component/splash_logo.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final shortest = math.min(width, height);
        final isCompact = height < 640;
        final isLandscape = width > height;

        final horizontalPad = (width * 0.08).clamp(20.0, 48.0);
        final topPad = (height * (isLandscape ? 0.04 : 0.06)).clamp(12.0, 48.0);
        final bottomPad = (height * 0.045).clamp(12.0, 36.0);
        final logoSize = (shortest * (isLandscape ? 0.14 : 0.2)).clamp(56.0, 96.0);
        final titleSize = (shortest * 0.065).clamp(20.0, 30.0);
        final taglineSize = (shortest * 0.032).clamp(12.0, 15.0);
        final loadingSize = (shortest * 0.032).clamp(12.0, 14.0);
        final spinnerSize = (shortest * 0.055).clamp(22.0, 28.0);

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPad,
              topPad,
              horizontalPad,
              bottomPad,
            ),
            child: Column(
              children: [
                SplashLogo(size: logoSize),
                SizedBox(height: isCompact ? 10 : 16),
                Text(
                  'appTitle'.tr(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: SplashColors.textPrimary,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: isCompact ? 6 : 10),
                Container(
                  width: (width * 0.28).clamp(72.0, 128.0),
                  height: 2,
                  decoration: BoxDecoration(
                    color: SplashColors.textPrimary.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                SizedBox(height: isCompact ? 6 : 10),
                Text(
                  '।। ${'appTagline'.tr()} ।।',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: SplashColors.textSecondary,
                    fontSize: taglineSize,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: spinnerSize,
                  height: spinnerSize,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: SplashColors.primary,
                  ),
                ),
                SizedBox(height: isCompact ? 8 : 12),
                Text(
                  'splashLoading'.tr(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: SplashColors.textSecondary,
                    fontSize: loadingSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
