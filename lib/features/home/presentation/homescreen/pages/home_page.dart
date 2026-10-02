import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/router/app_router.gr.dart';
import 'package:infocontract/features/aarti/presentation/aarti_navigation.dart';
import 'package:infocontract/features/home/bloc/cubit/home_cubit.dart';
import 'package:infocontract/features/home/bloc/cubit/home_state.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/home/presentation/widgets/component/category_section.dart';
import 'package:infocontract/features/home/presentation/widgets/component/hero_carousel.dart';
import 'package:infocontract/features/home/presentation/widgets/component/home_app_bar.dart';
import 'package:infocontract/features/home/presentation/widgets/component/popular_aarti_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AartiColors.background,
      appBar: HomeAppBar(
        onMenuTap: onMenuTap,
        onSearchTap: () => context.router.push(const SearchRoute()),
        onNotificationTap: () => context.router.push(const NotificationsRoute()),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading && state.popularAartis.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AartiColors.primary),
            );
          }

          return RefreshIndicator(
            color: AartiColors.primary,
            onRefresh: () => context.read<HomeCubit>().refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  HeroCarousel(
                    banners: state.banners,
                    currentIndex: state.currentBannerIndex,
                    onPageChanged: context.read<HomeCubit>().updateBannerIndex,
                  ),
                  const SizedBox(height: 24),
                  CategorySection(
                    categories: state.categories,
                    selectedCategoryId: state.selectedCategoryId,
                    onCategorySelected: context.read<HomeCubit>().selectCategory,
                  ),
                  const SizedBox(height: 24),
                  PopularAartiSection(
                    aartis: state.popularAartis,
                    isLoading: state.isAartisLoading,
                    onFavoriteTap: context.read<HomeCubit>().toggleFavorite,
                    onPlayTap: (id) => openAartiDetail(context, id),
                    onAartiTap: (id) => openAartiDetail(context, id),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
