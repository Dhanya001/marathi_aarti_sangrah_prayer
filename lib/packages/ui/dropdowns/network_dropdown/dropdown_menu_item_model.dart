class DropdownMenuItemModel {
  final int id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final dynamic value;

  DropdownMenuItemModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.value,
  });
  factory DropdownMenuItemModel.fromJson(Map<String, dynamic> json) {
    return DropdownMenuItemModel(
      id: json['id'] as int,
      title: json['title'] ?? json['name'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['image_url'] as String?,
      value: json['value'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'image_url': imageUrl,
    };
  }
}
