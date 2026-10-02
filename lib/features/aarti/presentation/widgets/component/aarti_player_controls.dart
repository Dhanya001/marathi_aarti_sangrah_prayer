import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/aarti/bloc/cubit/aarti_player_state.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class AartiPlayerControls extends StatelessWidget {
  const AartiPlayerControls({
    super.key,
    required this.state,
    required this.onSeek,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
    required this.onSkipBack,
    required this.onSkipForward,
    required this.onRepeat,
    required this.onLoopAll,
  });

  final AartiPlayerState state;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSkipBack;
  final VoidCallback onSkipForward;
  final VoidCallback onRepeat;
  final VoidCallback onLoopAll;

  @override
  Widget build(BuildContext context) {
    final durationMs = state.duration.inMilliseconds;
    final positionMs = state.position.inMilliseconds.clamp(0, durationMs == 0 ? 0 : durationMs);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: AartiColors.primary,
              inactiveTrackColor: AartiColors.divider,
              thumbColor: AartiColors.primary,
            ),
            child: Slider(
              min: 0,
              max: durationMs == 0 ? 1 : durationMs.toDouble(),
              value: durationMs == 0 ? 0 : positionMs.toDouble(),
              onChanged: durationMs == 0
                  ? null
                  : (value) => onSeek(Duration(milliseconds: value.round())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_format(state.position), style: _timeStyle),
                Text(_format(state.duration), style: _timeStyle),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LabeledIcon(
                icon: Icons.repeat_one_rounded,
                label: 'aartiRepeat'.tr(),
                selected: state.isRepeatOne,
                onTap: onRepeat,
              ),
              _LabeledIcon(
                icon: Icons.replay_10_rounded,
                label: 'aartiSkipBack'.tr(),
                onTap: onSkipBack,
              ),
              IconButton(
                onPressed: onPrevious,
                icon: const Icon(Icons.skip_previous_rounded, size: 32),
                color: AartiColors.textPrimary,
              ),
              GestureDetector(
                onTap: onPlayPause,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AartiColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    state.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.skip_next_rounded, size: 32),
                color: AartiColors.textPrimary,
              ),
              _LabeledIcon(
                icon: Icons.forward_10_rounded,
                label: 'aartiSkipForward'.tr(),
                onTap: onSkipForward,
              ),
              _LabeledIcon(
                icon: Icons.all_inclusive_rounded,
                label: 'aartiLoopAll'.tr(),
                selected: state.isLoopAll,
                onTap: onLoopAll,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const _timeStyle = TextStyle(
    color: AartiColors.textSecondary,
    fontSize: 12,
  );

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _LabeledIcon extends StatelessWidget {
  const _LabeledIcon({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AartiColors.primary : AartiColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Column(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            SizedBox(
              width: 52,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
