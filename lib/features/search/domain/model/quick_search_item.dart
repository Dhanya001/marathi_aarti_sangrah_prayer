import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuickSearchItem extends Equatable {
  const QuickSearchItem({
    required this.id,
    required this.labelKey,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String id;
  final String labelKey;
  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  List<Object?> get props => [id, labelKey, icon, background, foreground];
}
