import 'package:equatable/equatable.dart';
import 'package:infocontract/features/aarti/domain/model/aarti_content_tab.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';

enum AartiPlayerStatus { initial, loading, success, empty, error }

class AartiPlayerState extends Equatable {
  const AartiPlayerState({
    this.status = AartiPlayerStatus.initial,
    this.aartis = const [],
    this.currentIndex = 0,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.isLoading = true,
    this.isRepeatOne = false,
    this.isLoopAll = false,
    this.isShuffle = false,
    this.hasError = false,
    this.errorMessage,
    this.contentTab = AartiContentTab.lyrics,
  });

  final AartiPlayerStatus status;
  final List<AartiModel> aartis;
  final int currentIndex;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isLoading;
  final bool isRepeatOne;
  final bool isLoopAll;
  final bool isShuffle;
  final bool hasError;
  final String? errorMessage;
  final AartiContentTab contentTab;

  bool get isInitial => status == AartiPlayerStatus.initial;
  bool get isSuccess => status == AartiPlayerStatus.success;
  bool get isEmpty => status == AartiPlayerStatus.empty || aartis.isEmpty;
  bool get isError => status == AartiPlayerStatus.error || hasError;

  AartiModel? get currentAarti =>
      aartis.isEmpty ? null : aartis[currentIndex.clamp(0, aartis.length - 1)];

  AartiModel? get nextAarti {
    if (aartis.length < 2) return null;
    return aartis[(currentIndex + 1) % aartis.length];
  }

  AartiPlayerState copyWith({
    AartiPlayerStatus? status,
    List<AartiModel>? aartis,
    int? currentIndex,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    bool? isLoading,
    bool? isRepeatOne,
    bool? isLoopAll,
    bool? isShuffle,
    bool? hasError,
    String? errorMessage,
    AartiContentTab? contentTab,
  }) {
    return AartiPlayerState(
      status: status ?? this.status,
      aartis: aartis ?? this.aartis,
      currentIndex: currentIndex ?? this.currentIndex,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isRepeatOne: isRepeatOne ?? this.isRepeatOne,
      isLoopAll: isLoopAll ?? this.isLoopAll,
      isShuffle: isShuffle ?? this.isShuffle,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      contentTab: contentTab ?? this.contentTab,
    );
  }

  @override
  List<Object?> get props => [
        status,
        aartis,
        currentIndex,
        position,
        duration,
        isPlaying,
        isLoading,
        isRepeatOne,
        isLoopAll,
        isShuffle,
        hasError,
        errorMessage,
        contentTab,
      ];
}

