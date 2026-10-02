import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/features/home/domain/model/bottom_nav_item.dart';

enum DrawerMenuId {
  profile,
  home,
  allAartis,
  favorites,
  offline,
  deities,
  temples,
  festivals,
  dailyAarti,
  settings,
  share,
  feedback,
  about,
}

class DrawerMenuItem extends Equatable {
  const DrawerMenuItem({
    required this.id,
    required this.titleKey,
    required this.icon,
    this.subtitleKey,
    this.tab,
    this.isHighlighted = false,
  });

  final DrawerMenuId id;
  final String titleKey;
  final String? subtitleKey;
  final IconData icon;
  final BottomNavTab? tab;
  final bool isHighlighted;

  @override
  List<Object?> get props => [id, titleKey, subtitleKey, icon, tab, isHighlighted];
}
