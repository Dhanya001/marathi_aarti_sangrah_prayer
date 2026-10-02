import 'package:equatable/equatable.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/model/banner_model.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';

class HomeState extends Equatable {
  const HomeState({
    this.banners = const [],
    this.categories = const [],
    this.popularAartis = const [],
    this.currentBannerIndex = 0,
    this.isLoading = false,
  });

  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<AartiModel> popularAartis;
  final int currentBannerIndex;
  final bool isLoading;

  HomeState copyWith({
    List<BannerModel>? banners,
    List<CategoryModel>? categories,
    List<AartiModel>? popularAartis,
    int? currentBannerIndex,
    bool? isLoading,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      popularAartis: popularAartis ?? this.popularAartis,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        banners,
        categories,
        popularAartis,
        currentBannerIndex,
        isLoading,
      ];
}
