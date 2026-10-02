import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/aarti/presentation/aarti_navigation.dart';
import 'package:infocontract/features/home/bloc/cubit/home_cubit.dart';
import 'package:infocontract/features/home/bloc/cubit/home_state.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_list_tile.dart';

class AartisPage extends StatelessWidget {
  const AartisPage({super.key});

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
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.popularAartis.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final aarti = state.popularAartis[index];
              return AartiListTile(
                aarti: aarti,
                onFavoriteTap: () =>
                    context.read<HomeCubit>().toggleFavorite(aarti.id),
                onPlayTap: () => openAartiDetail(context, aarti.id),
                onTap: () => openAartiDetail(context, aarti.id),
              );
            },
          );
        },
      ),
    );
  }
}
