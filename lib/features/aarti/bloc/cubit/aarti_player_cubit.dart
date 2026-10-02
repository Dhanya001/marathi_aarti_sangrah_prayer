import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/features/aarti/bloc/cubit/aarti_player_state.dart';
import 'package:infocontract/features/aarti/domain/model/aarti_content_tab.dart';
import 'package:infocontract/features/aarti/domain/service/aarti_service.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';

class AartiPlayerCubit extends Cubit<AartiPlayerState> {
  AartiPlayerCubit({
    required String initialAartiId,
    AartiService? aartiService,
    AudioPlayer? audioPlayer,
  })  : _aartiService = aartiService ?? locator<AartiService>(),
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
    emit(
      state.copyWith(
        isLoading: true,
        hasError: false,
        status: AartiPlayerStatus.loading,
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
      // Fetch the specific Aarti by ID from GET /api/v1/aartis/:id
      // and the surrounding playlist from GET /api/v1/aartis
      final detailFuture = _aartiService.getAartiById(aartiId);
      final listFuture = _aartiService.getAartis(page: 1, limit: 20);

      final results = await Future.wait([detailFuture, listFuture]);
      final detailResult = results[0];
      final listResult = results[1];

      List<AartiModel> aartis = [];
      if (listResult.isSuccess && listResult.data != null) {
        aartis = List<AartiModel>.from(listResult.data as List<AartiModel>);
      }

      int startIndex = 0;
      if (detailResult.isSuccess && detailResult.data != null) {
        final detailAarti = detailResult.data as AartiModel;
        final existingIdx = aartis.indexWhere((a) => a.id == detailAarti.id);
        if (existingIdx >= 0) {
          aartis[existingIdx] = detailAarti;
          startIndex = existingIdx;
        } else {
          aartis.insert(0, detailAarti);
          startIndex = 0;
        }
      } else {
        final existingIdx = aartis.indexWhere((a) => a.id == aartiId);
        startIndex = existingIdx < 0 ? 0 : existingIdx;
      }

      if (aartis.isEmpty) {
        emit(
          state.copyWith(
            isLoading: false,
            hasError: true,
            status: AartiPlayerStatus.empty,
            errorMessage: 'Aarti not found',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          aartis: aartis,
          currentIndex: startIndex,
          isLoading: false,
          hasError: false,
          status: AartiPlayerStatus.success,
        ),
      );

      // Load audio sources into just_audio player
      final playableSources = <AudioSource>[];
      for (final aarti in aartis) {
        final url = ApiConstants.resolveMediaUrl(aarti.audioUrl);
        if (url.isNotEmpty && (url.startsWith('http://') || url.startsWith('https://'))) {
          playableSources.add(AudioSource.uri(Uri.parse(url)));
        } else {
          // Fallback placeholder or dummy source so index aligns
          playableSources.add(AudioSource.uri(Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3')));
        }
      }

      if (playableSources.isNotEmpty) {
        await _player.setAudioSources(
          playableSources,
          initialIndex: startIndex.clamp(0, playableSources.length - 1),
        );
        await _player.play();
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            hasError: true,
            isPlaying: false,
            status: AartiPlayerStatus.error,
            errorMessage: e.toString(),
          ),
        );
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
