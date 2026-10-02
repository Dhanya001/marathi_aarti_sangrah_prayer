import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/model/banner_model.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/features/home/domain/model/drawer_menu_item.dart';

class HomeService {
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

  List<CategoryModel> getCategories() {
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

  List<AartiModel> getPopularAartis() {
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
