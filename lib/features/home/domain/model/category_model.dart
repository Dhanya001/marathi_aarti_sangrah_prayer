import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    String? name,
    String? labelKey,
    IconData? icon,
    this.imageUrl,
    this.description,
    this.sortOrder,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  })  : _name = name,
        _labelKey = labelKey,
        _icon = icon;

  final String id;
  final String? _name;
  final String? _labelKey;
  final IconData? _icon;
  final String? imageUrl;
  final String? description;
  final int? sortOrder;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Returns the category name, falling back to labelKey.
  String get name => _name ?? _labelKey ?? '';

  /// Returns the translation labelKey, falling back to name.
  String get labelKey => _labelKey ?? _name ?? '';

  /// Returns the category icon, with sensible defaults based on name/id.
  IconData get icon => _icon ?? _defaultIcon(name, id);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: (json['name'] ?? json['title'] ?? json['labelKey'] ?? '') as String,
      labelKey: json['labelKey'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      sortOrder: json['sortOrder'] is int
          ? json['sortOrder'] as int
          : int.tryParse(json['sortOrder']?.toString() ?? ''),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      icon: _parseIcon(json['icon']?.toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (_labelKey != null) 'labelKey': _labelKey,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (isActive != null) 'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? labelKey,
    IconData? icon,
    String? imageUrl,
    String? description,
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? _name,
      labelKey: labelKey ?? _labelKey,
      icon: icon ?? _icon,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static IconData? _parseIcon(String? iconName) {
    if (iconName == null) return null;
    return switch (iconName.toLowerCase()) {
      'temple' || 'temple_hindu' => Icons.temple_hindu_outlined,
      'festival' || 'fire' => Icons.local_fire_department_outlined,
      'morning' || 'sun' => Icons.wb_sunny_outlined,
      'night' || 'moon' => Icons.nightlight_round_outlined,
      'spa' || 'flower' => Icons.spa_outlined,
      _ => null,
    };
  }

  static IconData _defaultIcon(String name, String id) {
    final lower = '${name.toLowerCase()} ${id.toLowerCase()}';
    if (lower.contains('temple') || lower.contains('मंदिर')) {
      return Icons.temple_hindu_outlined;
    }
    if (lower.contains('fest') || lower.contains('उत्सव')) {
      return Icons.local_fire_department_outlined;
    }
    if (lower.contains('morn') || lower.contains('सकाळ')) {
      return Icons.wb_sunny_outlined;
    }
    if (lower.contains('night') || lower.contains('रात्र')) {
      return Icons.nightlight_round_outlined;
    }
    return Icons.spa_outlined;
  }

  @override
  List<Object?> get props => [
        id,
        _name,
        _labelKey,
        _icon,
        imageUrl,
        description,
        sortOrder,
        isActive,
      ];
}

