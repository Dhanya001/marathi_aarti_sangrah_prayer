import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/model/banner_model.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';

enum HomeStatus { initial, loading, success, empty, error }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.banners = const [],
    this.categories = const [],
    this.popularAartis = const [],
    this.currentBannerIndex = 0,
    this.isLoading = false,
    this.isCategoriesLoading = false,
    this.isAartisLoading = false,
    this.selectedCategoryId,
    this.errorMessage,
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  final HomeStatus status;
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<AartiModel> popularAartis;
  final int currentBannerIndex;
  final bool isLoading;
  final bool isCategoriesLoading;
  final bool isAartisLoading;
  final int? selectedCategoryId;
  final String? errorMessage;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  bool get isInitial => status == HomeStatus.initial;
  bool get isSuccess => status == HomeStatus.success;
  bool get isEmpty => status == HomeStatus.empty || (popularAartis.isEmpty && !isLoading);
  bool get isError => status == HomeStatus.error;

  HomeState copyWith({
    HomeStatus? status,
    List<BannerModel>? banners,
    List<CategoryModel>? categories,
    List<AartiModel>? popularAartis,
    int? currentBannerIndex,
    bool? isLoading,
    bool? isCategoriesLoading,
    bool? isAartisLoading,
    ValueGetter<int?>? selectedCategoryId,
    String? errorMessage,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return HomeState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      popularAartis: popularAartis ?? this.popularAartis,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      isLoading: isLoading ?? this.isLoading,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isAartisLoading: isAartisLoading ?? this.isAartisLoading,
      selectedCategoryId: selectedCategoryId != null
          ? selectedCategoryId()
          : this.selectedCategoryId,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        banners,
        categories,
        popularAartis,
        currentBannerIndex,
        isLoading,
        isCategoriesLoading,
        isAartisLoading,
        selectedCategoryId,
        errorMessage,
        page,
        hasMore,
        isLoadingMore,
      ];
}

