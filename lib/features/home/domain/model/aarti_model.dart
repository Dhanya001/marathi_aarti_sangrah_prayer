import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/packages/ui/list/models/list_base_model.dart';

class AartiModel extends ListBaseModel {
  const AartiModel({
    required this.id,
    String? title,
    String? titleKey,
    String? subtitle,
    String? lyrics,
    String? lyricsKey,
    String? lyricsFullKey,
    String? meaning,
    String? meaningKey,
    String? info,
    String? infoKey,
    this.categoryId,
    this.category,
    this.imageUrl,
    this.audioUrl = '',
    this.duration,
    this.isPopular = false,
    this.isFeatured = false,
    this.isActive = true,
    this.sortOrder,
    this.playCount = 0,
    String? categoryKey,
    String? languageKey,
    this.imageAsset = '',
    this.isFavorite = false,
    this.createdAt,
    this.updatedAt,
  })  : _title = title,
        _titleKey = titleKey,
        _subtitle = subtitle,
        _lyrics = lyrics,
        _lyricsKey = lyricsKey,
        _lyricsFullKey = lyricsFullKey,
        _meaning = meaning,
        _meaningKey = meaningKey,
        _info = info,
        _infoKey = infoKey,
        _categoryKey = categoryKey,
        _languageKey = languageKey;

  final String id;
  final String? _title;
  final String? _titleKey;
  final String? _subtitle;
  final String? _lyrics;
  final String? _lyricsKey;
  final String? _lyricsFullKey;
  final String? _meaning;
  final String? _meaningKey;
  final String? _info;
  final String? _infoKey;
  final int? categoryId;
  final CategoryModel? category;
  final String? imageUrl;
  final String audioUrl;
  final String? duration;
  final bool isPopular;
  final bool isFeatured;
  final bool isActive;
  final int? sortOrder;
  final int playCount;
  final String? _categoryKey;
  final String? _languageKey;
  final String imageAsset;
  final bool isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Backend getters
  String get title => _title ?? _titleKey ?? '';
  String? get subtitle => _subtitle ?? _lyricsKey;
  String? get lyrics => _lyrics ?? _lyricsFullKey;
  String? get meaning => _meaning ?? _meaningKey;
  String? get info => _info ?? _infoKey;

  // UI backward-compatibility getters
  String get titleKey => _titleKey ?? _title ?? '';
  String get lyricsKey {
    if (_lyricsKey != null) return _lyricsKey;
    if (_subtitle != null) return _subtitle;
    final l = _lyrics;
    if (l != null && l.length > 40) {
      return '${l.substring(0, 40)}...';
    }
    return l ?? '';
  }
  String get lyricsFullKey => _lyricsFullKey ?? _lyrics ?? '';
  String get meaningKey => _meaningKey ?? _meaning ?? '';
  String get infoKey => _infoKey ?? _info ?? '';
  String get categoryKey =>
      _categoryKey ??
      category?.name ??
      (categoryId != null ? 'Category $categoryId' : '');
  String get languageKey => _languageKey ?? 'मराठी';

  @override
  AartiModel fromJsonListBase(Map<String, dynamic> json) =>
      AartiModel.fromJson(json);

  factory AartiModel.fromJson(Map<String, dynamic> json) {
    CategoryModel? cat;
    if (json['category'] != null && json['category'] is Map<String, dynamic>) {
      cat = CategoryModel.fromJson(json['category'] as Map<String, dynamic>);
    } else if (json['category'] != null && json['category'] is Map) {
      cat = CategoryModel.fromJson(
        Map<String, dynamic>.from(json['category'] as Map),
      );
    }

    return AartiModel(
      id: json['id']?.toString() ?? '',
      title: (json['title'] ?? json['titleKey'] ?? '') as String,
      titleKey: json['titleKey'] as String?,
      subtitle: (json['subtitle'] ?? json['lyricsKey']) as String?,
      lyrics: (json['lyrics'] ?? json['lyricsFullKey']) as String?,
      lyricsKey: json['lyricsKey'] as String?,
      lyricsFullKey: json['lyricsFullKey'] as String?,
      meaning: (json['meaning'] ?? json['meaningKey']) as String?,
      meaningKey: json['meaningKey'] as String?,
      info: (json['info'] ?? json['infoKey']) as String?,
      infoKey: json['infoKey'] as String?,
      categoryId: json['categoryId'] is int
          ? json['categoryId'] as int
          : int.tryParse(json['categoryId']?.toString() ?? ''),
      category: cat,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: (json['audioUrl'] ?? '') as String,
      duration: json['duration']?.toString(),
      isPopular: json['isPopular'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: json['sortOrder'] is int
          ? json['sortOrder'] as int
          : int.tryParse(json['sortOrder']?.toString() ?? ''),
      playCount: json['playCount'] is int
          ? json['playCount'] as int
          : int.tryParse(json['playCount']?.toString() ?? '') ?? 0,
      imageAsset: (json['imageAsset'] ?? '') as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      if (_titleKey != null) 'titleKey': _titleKey,
      if (subtitle != null) 'subtitle': subtitle,
      if (lyrics != null) 'lyrics': lyrics,
      if (meaning != null) 'meaning': meaning,
      if (info != null) 'info': info,
      if (categoryId != null) 'categoryId': categoryId,
      if (category != null) 'category': category!.toJson(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      if (duration != null) 'duration': duration,
      'isPopular': isPopular,
      'isFeatured': isFeatured,
      'isActive': isActive,
      if (sortOrder != null) 'sortOrder': sortOrder,
      'playCount': playCount,
      if (_categoryKey != null) 'categoryKey': _categoryKey,
      if (_languageKey != null) 'languageKey': _languageKey,
      'imageAsset': imageAsset,
      'isFavorite': isFavorite,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  AartiModel copyWith({
    String? id,
    String? title,
    String? titleKey,
    String? subtitle,
    String? lyrics,
    String? lyricsKey,
    String? lyricsFullKey,
    String? meaning,
    String? meaningKey,
    String? info,
    String? infoKey,
    int? categoryId,
    CategoryModel? category,
    String? imageUrl,
    String? audioUrl,
    String? duration,
    bool? isPopular,
    bool? isFeatured,
    bool? isActive,
    int? sortOrder,
    int? playCount,
    String? categoryKey,
    String? languageKey,
    String? imageAsset,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AartiModel(
      id: id ?? this.id,
      title: title ?? _title,
      titleKey: titleKey ?? _titleKey,
      subtitle: subtitle ?? _subtitle,
      lyrics: lyrics ?? _lyrics,
      lyricsKey: lyricsKey ?? _lyricsKey,
      lyricsFullKey: lyricsFullKey ?? _lyricsFullKey,
      meaning: meaning ?? _meaning,
      meaningKey: meaningKey ?? _meaningKey,
      info: info ?? _info,
      infoKey: infoKey ?? _infoKey,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      isPopular: isPopular ?? this.isPopular,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      playCount: playCount ?? this.playCount,
      categoryKey: categoryKey ?? _categoryKey,
      languageKey: languageKey ?? _languageKey,
      imageAsset: imageAsset ?? this.imageAsset,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        _title,
        _titleKey,
        _subtitle,
        _lyrics,
        _lyricsKey,
        _lyricsFullKey,
        _meaning,
        _meaningKey,
        _info,
        _infoKey,
        categoryId,
        category,
        imageUrl,
        audioUrl,
        duration,
        isPopular,
        isFeatured,
        isActive,
        sortOrder,
        playCount,
        _categoryKey,
        _languageKey,
        imageAsset,
        isFavorite,
      ];
}

