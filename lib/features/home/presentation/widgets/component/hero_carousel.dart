import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/banner_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class HeroCarousel extends StatelessWidget {
  const HeroCarousel({
    super.key,
    required this.banners,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final List<BannerModel> banners;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: banners.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFE86B1A),
                              Color(0xFF8B4513),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.local_fire_department_rounded,
                            size: 64,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.55),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 20,
                        child: Text(
                          banner.titleKey.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              final isActive = index == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? AartiColors.primary : AartiColors.divider,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
