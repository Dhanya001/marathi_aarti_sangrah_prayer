import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  const BannerModel({
    required this.id,
    required this.titleKey,
    required this.imageAsset,
  });

  final String id;
  final String titleKey;
  final String imageAsset;

  @override
  List<Object?> get props => [id, titleKey, imageAsset];
}
