import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:infocontract/features/aarti/bloc/cubit/aarti_player_state.dart';
import 'package:infocontract/features/aarti/domain/model/aarti_content_tab.dart';
import 'package:infocontract/features/aarti/domain/service/aarti_service.dart';

class AartiPlayerCubit extends Cubit<AartiPlayerState> {
  AartiPlayerCubit({
    required String initialAartiId,
    AartiService? aartiService,
    AudioPlayer? audioPlayer,
  })  : _aartiService = aartiService ?? AartiService(),
        _player = audioPlayer ?? AudioPlayer(),
        super(const AartiPlayerState()) {
    _init(initialAartiId);
  }

  final AartiService _aartiService;
  final AudioPlayer _player;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<int?>? _indexSub;

  Future<void> _init(String aartiId) async {
    final aartis = _aartiService.getAartis();
    final index = aartis.indexWhere((aarti) => aarti.id == aartiId);
    final startIndex = index < 0 ? 0 : index;

    emit(
      state.copyWith(
        aartis: aartis,
        currentIndex: startIndex,
        isLoading: true,
        hasError: false,
      ),
    );

    _positionSub = _player.positionStream.listen((position) {
      if (!isClosed) emit(state.copyWith(position: position));
    });
    _durationSub = _player.durationStream.listen((duration) {
      if (!isClosed) emit(state.copyWith(duration: duration ?? Duration.zero));
    });
    _playerStateSub = _player.playerStateStream.listen((playerState) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isPlaying: playerState.playing,
          isLoading: playerState.processingState == ProcessingState.loading ||
              playerState.processingState == ProcessingState.buffering,
        ),
      );
    });
    _indexSub = _player.currentIndexStream.listen((currentIndex) {
      if (isClosed || currentIndex == null) return;
      emit(state.copyWith(currentIndex: currentIndex));
    });

    try {
      await _player.setAudioSources(
        aartis
            .map((aarti) => AudioSource.uri(Uri.parse(aarti.audioUrl)))
            .toList(),
        initialIndex: startIndex,
      );
      await _player.play();
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, hasError: true, isPlaying: false));
      }
    }
  }

  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seek(Duration position) {
    return _player.seek(position);
  }

  Future<void> skipForward() {
    final next = state.position + const Duration(seconds: 10);
    final max = state.duration == Duration.zero ? next : state.duration;
    return _player.seek(next > max ? max : next);
  }

  Future<void> skipBackward() {
    final previous = state.position - const Duration(seconds: 10);
    return _player.seek(previous.isNegative ? Duration.zero : previous);
  }

  Future<void> next() => _player.seekToNext();

  Future<void> previous() => _player.seekToPrevious();

  Future<void> playAartiAt(int index) async {
    if (index < 0 || index >= state.aartis.length) return;
    await _player.seek(Duration.zero, index: index);
    await _player.play();
  }

  Future<void> toggleRepeatOne() async {
    final enabled = !state.isRepeatOne;
    await _player.setLoopMode(enabled ? LoopMode.one : LoopMode.off);
    emit(
      state.copyWith(
        isRepeatOne: enabled,
        isLoopAll: enabled ? false : state.isLoopAll,
      ),
    );
  }

  Future<void> toggleLoopAll() async {
    final enabled = !state.isLoopAll;
    await _player.setLoopMode(enabled ? LoopMode.all : LoopMode.off);
    emit(
      state.copyWith(
        isLoopAll: enabled,
        isRepeatOne: enabled ? false : state.isRepeatOne,
      ),
    );
  }

  Future<void> toggleShuffle() async {
    final enabled = !state.isShuffle;
    await _player.setShuffleModeEnabled(enabled);
    emit(state.copyWith(isShuffle: enabled));
  }

  void changeTab(AartiContentTab tab) {
    emit(state.copyWith(contentTab: tab));
  }

  Future<void> toggleFavorite() async {
    final current = state.currentAarti;
    if (current == null) return;
    await _aartiService.toggleFavorite(current.id);
    final updated = state.aartis
        .map(
          (aarti) => aarti.id == current.id
              ? aarti.copyWith(isFavorite: !aarti.isFavorite)
              : aarti,
        )
        .toList();
    emit(state.copyWith(aartis: updated));
  }

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    await _playerStateSub?.cancel();
    await _indexSub?.cancel();
    await _player.dispose();
    return super.close();
  }
}
