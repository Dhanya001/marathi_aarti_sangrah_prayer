import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum BottomNavTab { home, aartis, suvidha, favorites, settings }

class BottomNavItem extends Equatable {
  const BottomNavItem({
    required this.tab,
    required this.labelKey,
    required this.icon,
    required this.activeIcon,
  });

  final BottomNavTab tab;
  final String labelKey;
  final IconData icon;
  final IconData activeIcon;

  @override
  List<Object?> get props => [tab, labelKey, icon, activeIcon];
}
