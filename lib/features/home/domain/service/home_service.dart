import 'package:flutter/material.dart';
import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/api/api_result.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/model/banner_model.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/features/home/domain/model/drawer_menu_item.dart';

class HomeService {
  HomeService({
    ApiDioClient? dioClient,
    SharedPref? sharedPref,
  })  : _dioClient = dioClient ?? locator<ApiDioClient>(),
        _sharedPref = sharedPref ?? locator<SharedPref>();

  final ApiDioClient _dioClient;
  final SharedPref _sharedPref;

  /// Fetches categories from the backend GET /categories
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    final response = await _dioClient.get(ApiConstants.categories);

    if (response.isSuccess && response.data != null) {
      final rawData = response.data;
      List<dynamic> items = [];

      if (rawData is Map && rawData['data'] != null) {
        final nested = rawData['data'];
        if (nested is List) {
          items = nested;
        } else if (nested is Map && nested['items'] is List) {
          items = nested['items'] as List;
        }
      } else if (rawData is List) {
        items = rawData;
      } else if (rawData is Map && rawData['items'] is List) {
        items = rawData['items'] as List;
      }

      final categories = items
          .map((json) => CategoryModel.fromJson(Map<String, dynamic>.from(json as Map)))
          .toList();

      return ApiResult.success(categories, statusCode: response.statusCode);
    }

    return ApiResult.error(
      response.errorMessage ?? 'Failed to load categories',
      statusCode: response.statusCode,
    );
  }

  /// Fetches a category by ID from GET /categories/:id
  Future<ApiResult<CategoryModel>> getCategoryById(dynamic id) async {
    final response = await _dioClient.get(ApiConstants.categoryById(id));

    if (response.isSuccess && response.data != null) {
      final rawData = response.data;
      Map<String, dynamic>? itemMap;

      if (rawData is Map && rawData['data'] is Map) {
        itemMap = Map<String, dynamic>.from(rawData['data'] as Map);
      } else if (rawData is Map<String, dynamic>) {
        itemMap = rawData;
      }

      if (itemMap != null) {
        final category = CategoryModel.fromJson(itemMap);
        return ApiResult.success(category, statusCode: response.statusCode);
      }
    }

    return ApiResult.error(
      response.errorMessage ?? 'Failed to load category',
      statusCode: response.statusCode,
    );
  }

  /// Fetches popular aartis from GET /aartis, optionally filtered by category
  Future<ApiResult<List<AartiModel>>> getPopularAartis({
    int? categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (categoryId != null) {
      queryParameters['categoryId'] = categoryId;
    }

    final response = await _dioClient.get(
      ApiConstants.aartis,
      queryParameters: queryParameters,
    );

    if (response.isSuccess && response.data != null) {
      final rawData = response.data;
      List<dynamic> items = [];

      if (rawData is Map && rawData['data'] != null) {
        final nested = rawData['data'];
        if (nested is List) {
          items = nested;
        } else if (nested is Map && nested['items'] is List) {
          items = nested['items'] as List;
        } else if (nested is Map && nested['aartis'] is List) {
          items = nested['aartis'] as List;
        }
      } else if (rawData is List) {
        items = rawData;
      } else if (rawData is Map && rawData['items'] is List) {
        items = rawData['items'] as List;
      }

      final favoriteIds = _sharedPref.favoriteAartiIds;
      final aartis = items.map((json) {
        final model = AartiModel.fromJson(Map<String, dynamic>.from(json as Map));
        return model.copyWith(isFavorite: favoriteIds.contains(model.id));
      }).toList();

      return ApiResult.success(aartis, statusCode: response.statusCode);
    }

    return ApiResult.error(
      response.errorMessage ?? 'Failed to load popular aartis',
      statusCode: response.statusCode,
    );
  }

  List<BannerModel> getBanners() {

    return const [
      BannerModel(
        id: '1',
        titleKey: 'heroBanner1',
        imageAsset: '',
      ),
      BannerModel(
        id: '2',
        titleKey: 'heroBanner2',
        imageAsset: '',
      ),
      BannerModel(
        id: '3',
        titleKey: 'heroBanner3',
        imageAsset: '',
      ),
      BannerModel(
        id: '4',
        titleKey: 'heroBanner4',
        imageAsset: '',
      ),
    ];
  }

  List<CategoryModel> getDefaultCategories() {
    return const [
      CategoryModel(
        id: 'deities',
        labelKey: 'categoryDeities',
        icon: Icons.spa_outlined,
      ),
      CategoryModel(
        id: 'temples',
        labelKey: 'categoryTemples',
        icon: Icons.temple_hindu_outlined,
      ),
      CategoryModel(
        id: 'festivals',
        labelKey: 'categoryFestivals',
        icon: Icons.local_fire_department_outlined,
      ),
      CategoryModel(
        id: 'morning',
        labelKey: 'categoryMorning',
        icon: Icons.wb_sunny_outlined,
      ),
      CategoryModel(
        id: 'night',
        labelKey: 'categoryNight',
        icon: Icons.nightlight_round_outlined,
      ),
    ];
  }

  List<AartiModel> getDefaultPopularAartis() {
    return const [
      AartiModel(
        id: 'ganesh',
        titleKey: 'aartiGaneshTitle',
        lyricsKey: 'aartiGaneshLyrics',
        lyricsFullKey: 'aartiGaneshLyricsFull',
        meaningKey: 'aartiGaneshMeaning',
        infoKey: 'aartiGaneshInfo',
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        categoryKey: 'aartiCategoryTraditional',
        languageKey: 'aartiLanguageMarathi',
        playCount: 1236789,
      ),
      AartiModel(
        id: 'vitthal',
        titleKey: 'aartiVitthalTitle',
        lyricsKey: 'aartiVitthalLyrics',
        lyricsFullKey: 'aartiVitthalLyricsFull',
        meaningKey: 'aartiVitthalMeaning',
        infoKey: 'aartiVitthalInfo',
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        categoryKey: 'aartiCategoryTraditional',
        languageKey: 'aartiLanguageMarathi',
        playCount: 986421,
      ),
      AartiModel(
        id: 'durga',
        titleKey: 'aartiDurgaTitle',
        lyricsKey: 'aartiDurgaLyrics',
        lyricsFullKey: 'aartiDurgaLyricsFull',
        meaningKey: 'aartiDurgaMeaning',
        infoKey: 'aartiDurgaInfo',
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
        categoryKey: 'aartiCategoryTraditional',
        languageKey: 'aartiLanguageMarathi',
        playCount: 754210,
      ),
      AartiModel(
        id: 'shiva',
        titleKey: 'aartiShivaTitle',
        lyricsKey: 'aartiShivaLyrics',
        lyricsFullKey: 'aartiShivaLyricsFull',
        meaningKey: 'aartiShivaMeaning',
        infoKey: 'aartiShivaInfo',
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
        categoryKey: 'aartiCategoryTraditional',
        languageKey: 'aartiLanguageMarathi',
        playCount: 1102456,
      ),
    ];
  }

  List<BottomNavItem> getBottomNavItems() {
    return const [
      BottomNavItem(
        tab: BottomNavTab.home,
        labelKey: 'navHome',
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
      ),
      BottomNavItem(
        tab: BottomNavTab.aartis,
        labelKey: 'navAartis',
        icon: Icons.music_note_outlined,
        activeIcon: Icons.music_note_rounded,
      ),
      BottomNavItem(
        tab: BottomNavTab.suvidha,
        labelKey: 'navSuvidha',
        icon: Icons.local_fire_department_outlined,
        activeIcon: Icons.local_fire_department_rounded,
      ),
      BottomNavItem(
        tab: BottomNavTab.favorites,
        labelKey: 'navFavorites',
        icon: Icons.favorite_border_rounded,
        activeIcon: Icons.favorite_rounded,
      ),
      BottomNavItem(
        tab: BottomNavTab.settings,
        labelKey: 'navSettings',
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
      ),
    ];
  }

  List<DrawerMenuItem> getDrawerItems() {
    return const [
      DrawerMenuItem(
        id: DrawerMenuId.profile,
        titleKey: 'drawerDevotee',
        subtitleKey: 'drawerDevoteeSubtitle',
        icon: Icons.person_rounded,
        isHighlighted: true,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.home,
        titleKey: 'navHome',
        icon: Icons.home_rounded,
        tab: BottomNavTab.home,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.allAartis,
        titleKey: 'drawerAllAartis',
        icon: Icons.music_note_rounded,
        tab: BottomNavTab.aartis,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.favorites,
        titleKey: 'drawerFavoriteAartis',
        icon: Icons.favorite_border_rounded,
        tab: BottomNavTab.favorites,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.offline,
        titleKey: 'drawerOfflineAartis',
        icon: Icons.download_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.deities,
        titleKey: 'drawerDeityInfo',
        icon: Icons.volunteer_activism_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.temples,
        titleKey: 'drawerFamousTemples',
        icon: Icons.temple_hindu_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.festivals,
        titleKey: 'drawerFestivals',
        icon: Icons.calendar_month_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.dailyAarti,
        titleKey: 'drawerDailyAarti',
        subtitleKey: 'drawerDailyAartiSubtitle',
        icon: Icons.star_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.settings,
        titleKey: 'navSettings',
        icon: Icons.settings_rounded,
        tab: BottomNavTab.settings,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.share,
        titleKey: 'drawerShareApp',
        icon: Icons.share_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.feedback,
        titleKey: 'drawerFeedback',
        icon: Icons.chat_bubble_outline_rounded,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.about,
        titleKey: 'drawerAboutApp',
        icon: Icons.info_outline_rounded,
      ),
    ];
  }
}
