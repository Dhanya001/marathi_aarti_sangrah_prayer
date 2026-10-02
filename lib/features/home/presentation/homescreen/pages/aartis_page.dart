import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/aarti/presentation/aarti_navigation.dart';
import 'package:infocontract/features/home/bloc/cubit/home_cubit.dart';
import 'package:infocontract/features/home/bloc/cubit/home_state.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_list_tile.dart';

class AartisPage extends StatefulWidget {
  const AartisPage({super.key});

  @override
  State<AartisPage> createState() => _AartisPageState();
}

class _AartisPageState extends State<AartisPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeCubit>().loadMoreAartis();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AartiColors.background,
      appBar: AppBar(
        backgroundColor: AartiColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'navAartis'.tr(),
          style: const TextStyle(
            color: AartiColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading && state.popularAartis.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AartiColors.primary),
            );
          }

          if (state.popularAartis.isEmpty) {
            return RefreshIndicator(
              color: AartiColors.primary,
              onRefresh: () => context.read<HomeCubit>().refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Center(
                    child: Text(
                      'No aartis found',
                      style: const TextStyle(
                        color: AartiColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: AartiColors.primary,
            onRefresh: () => context.read<HomeCubit>().refresh(),
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.popularAartis.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                if (index == state.popularAartis.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AartiColors.primary,
                        ),
                      ),
                    ),
                  );
                }

                final aarti = state.popularAartis[index];
                return AartiListTile(
                  aarti: aarti,
                  onFavoriteTap: () =>
                      context.read<HomeCubit>().toggleFavorite(aarti.id),
                  onPlayTap: () => openAartiDetail(context, aarti.id),
                  onTap: () => openAartiDetail(context, aarti.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
