import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:infocontract/packages/ui/spacers/vertical_spacer.dart';

class NoItemFound extends StatelessWidget {
  final String title;
  final String subtitle;

  const NoItemFound({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NoItemIllustration(),
          const VSpacer(70),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const VSpacer(8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}


/// A reusable illustration widget that visually represents "no items found"
/// — with 3 stacked blurred cards, subtle shadows, and light gray placeholders.
class NoItemIllustration extends StatelessWidget {
  const NoItemIllustration({super.key});

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Back card (farthest)
        Positioned(
          top: -36,
          child: _card(opacity: 1, blur: 0, scale:1),
        ),
        // Middle card
        Positioned(
          top: 36,
          child: _card(opacity: 1, blur: 0, scale: 1),
        ),
        // Top visible card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(1, 30),
                  ),
                ],
              ),
              child: SizedBox(
                  width: double.infinity,
                  child: _card(opacity: 1, blur: 0, scale: 1)),
            ),
          ),
      ],
    );
  }

  /// Builds a single card with placeholder avatar + text lines.
  Widget _card({

    required double opacity,
    required double blur,
    required double scale,
  }) {


    const double baseWidth = 260;
    const double baseHeight = 80;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: baseWidth,
          height: baseHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Circle avatar placeholder
              Container(
                width: 41,
                height: 41,
                decoration: const BoxDecoration(
                  color: Color(0xFFE9ECEF),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              // Two text lines
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: 130),
                    const SizedBox(height: 14),
                    _line(width: 200, opacity: 0.85),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line({required double width, double opacity = 1.0}) {
    return Container(
      width: width,
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFFE9ECEF).withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
