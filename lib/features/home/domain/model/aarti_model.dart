import 'package:equatable/equatable.dart';

class AartiModel extends Equatable {
  const AartiModel({
    required this.id,
    required this.titleKey,
    required this.lyricsKey,
    required this.lyricsFullKey,
    required this.meaningKey,
    required this.infoKey,
    required this.audioUrl,
    required this.categoryKey,
    required this.languageKey,
    required this.playCount,
    this.imageAsset = '',
    this.isFavorite = false,
  });

  final String id;
  final String titleKey;
  final String lyricsKey;
  final String lyricsFullKey;
  final String meaningKey;
  final String infoKey;
  final String audioUrl;
  final String categoryKey;
  final String languageKey;
  final int playCount;
  final String imageAsset;
  final bool isFavorite;

  AartiModel copyWith({bool? isFavorite}) {
    return AartiModel(
      id: id,
      titleKey: titleKey,
      lyricsKey: lyricsKey,
      lyricsFullKey: lyricsFullKey,
      meaningKey: meaningKey,
      infoKey: infoKey,
      audioUrl: audioUrl,
      categoryKey: categoryKey,
      languageKey: languageKey,
      playCount: playCount,
      imageAsset: imageAsset,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        titleKey,
        lyricsKey,
        lyricsFullKey,
        meaningKey,
        infoKey,
        audioUrl,
        categoryKey,
        languageKey,
        playCount,
        imageAsset,
        isFavorite,
      ];
}
