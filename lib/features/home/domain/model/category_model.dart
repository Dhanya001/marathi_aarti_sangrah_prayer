import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.labelKey,
    required this.icon,
  });

  final String id;
  final String labelKey;
  final IconData icon;

  @override
  List<Object?> get props => [id, labelKey, icon];
}
