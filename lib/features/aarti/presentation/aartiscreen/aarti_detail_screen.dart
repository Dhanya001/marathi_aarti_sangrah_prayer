import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/aarti/bloc/cubit/aarti_player_cubit.dart';
import 'package:infocontract/features/aarti/bloc/cubit/aarti_player_state.dart';
import 'package:infocontract/features/aarti/presentation/widgets/component/aarti_content_tabs.dart';
import 'package:infocontract/features/aarti/presentation/widgets/component/aarti_header_card.dart';
import 'package:infocontract/features/aarti/presentation/widgets/component/aarti_lyrics_card.dart';
import 'package:infocontract/features/aarti/presentation/widgets/component/aarti_player_controls.dart';
import 'package:infocontract/features/aarti/presentation/widgets/component/next_aarti_card.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class AartiDetailScreen extends StatelessWidget {
  const AartiDetailScreen({
    super.key,
    @PathParam('aartiId') required this.aartiId,
  });

  final String aartiId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AartiPlayerCubit(initialAartiId: aartiId),
      child: const _AartiDetailView(),
    );
  }
}

class _AartiDetailView extends StatelessWidget {
  const _AartiDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AartiPlayerCubit, AartiPlayerState>(
      builder: (context, state) {
        final aarti = state.currentAarti;
        final cubit = context.read<AartiPlayerCubit>();

        return Scaffold(
          backgroundColor: AartiColors.background,
          appBar: AppBar(
            backgroundColor: AartiColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              onPressed: () => context.router.maybePop(),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AartiColors.textPrimary,
              ),
            ),
            title: Text(
              aarti?.titleKey.tr() ?? '',
              style: const TextStyle(
                color: AartiColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            actions: [
              IconButton(
                onPressed: cubit.toggleFavorite,
                icon: Icon(
                  aarti?.isFavorite == true
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: aarti?.isFavorite == true
                      ? AartiColors.primary
                      : AartiColors.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () => _share(aarti),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AartiColors.textPrimary,
                ),
              ),
            ],
          ),
          body: aarti == null
              ? const Center(
                  child: CircularProgressIndicator(color: AartiColors.primary),
                )
              : ListView(
                  children: [
                    AartiHeaderCard(
                      aarti: aarti,
                      onFavoriteTap: cubit.toggleFavorite,
                      onShareTap: () => _share(aarti),
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Text(
                          'aartiAudioError'.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AartiColors.primary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    AartiPlayerControls(
                      state: state,
                      onSeek: cubit.seek,
                      onPlayPause: cubit.togglePlayPause,
                      onPrevious: cubit.previous,
                      onNext: cubit.next,
                      onSkipBack: cubit.skipBackward,
                      onSkipForward: cubit.skipForward,
                      onRepeat: cubit.toggleRepeatOne,
                      onLoopAll: cubit.toggleLoopAll,
                    ),
                    if (state.nextAarti != null)
                      NextAartiCard(aarti: state.nextAarti!, onTap: cubit.next),
                    AartiContentTabs(
                      selected: state.contentTab,
                      onChanged: cubit.changeTab,
                    ),
                    AartiLyricsCard(aarti: aarti, tab: state.contentTab),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _share(AartiModel? aarti) async {
    if (aarti == null) return;
    await SharePlus.instance.share(
      ShareParams(text: '${aarti.titleKey.tr()}\n${aarti.lyricsKey.tr()}'),
    );
  }
}
