import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/features/aarti/domain/service/aarti_service.dart';
import 'package:infocontract/features/home/bloc/cubit/home_state.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    HomeService? homeService,
    AartiService? aartiService,
    SharedPref? sharedPref,
  })  : _homeService = homeService ?? locator<HomeService>(),
        _aartiService = aartiService ?? locator<AartiService>(),
        _sharedPref = sharedPref ?? locator<SharedPref>(),
        super(const HomeState(isLoading: true, status: HomeStatus.loading)) {
    loadHomeData();
  }

  final HomeService _homeService;
  final AartiService _aartiService;
  final SharedPref _sharedPref;

  /// Loads banners, categories, and initial aartis from backend APIs.
  Future<void> loadHomeData() async {
    emit(
      state.copyWith(
        isLoading: true,
        isCategoriesLoading: true,
        isAartisLoading: true,
        banners: _homeService.getBanners(),
        status: HomeStatus.loading,
      ),
    );

    try {
      // Fetch categories & popular aartis in parallel
      final results = await Future.wait([
        _homeService.getCategories(),
        _aartiService.getAartis(page: 1, limit: 10),
      ]);

      final catResult = results[0];
      final aartiResult = results[1];

      List<CategoryModel> categories = [];
      if (catResult.isSuccess && catResult.data != null && (catResult.data as List).isNotEmpty) {
        categories = (catResult.data as List).cast<CategoryModel>();
      } else {
        categories = _homeService.getDefaultCategories();
      }

      List<AartiModel> aartis = [];
      if (aartiResult.isSuccess && aartiResult.data != null && (aartiResult.data as List).isNotEmpty) {
        aartis = _withFavorites((aartiResult.data as List).cast<AartiModel>());
      } else {
        aartis = _withFavorites(_homeService.getDefaultPopularAartis());
      }

      final hasMore = (aartiResult.isSuccess && aartiResult.data != null)
          ? (aartiResult.data as List).length >= 10
          : false;

      emit(
        state.copyWith(
          isLoading: false,
          isCategoriesLoading: false,
          isAartisLoading: false,
          banners: _homeService.getBanners(),
          categories: categories,
          popularAartis: aartis,
          page: 1,
          hasMore: hasMore,
          status: aartis.isEmpty ? HomeStatus.empty : HomeStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isCategoriesLoading: false,
          isAartisLoading: false,
          categories: _homeService.getDefaultCategories(),
          popularAartis: _withFavorites(_homeService.getDefaultPopularAartis()),
          status: HomeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Category filter:
  /// When category is selected, queries `GET /api/v1/aartis?categoryId=<id>`
  /// When tapped again, deselects and resets to all aartis.
  /// Resets pagination when category changes.
  Future<void> selectCategory(CategoryModel? category) async {
    final catIdInt = category != null ? int.tryParse(category.id) : null;
    final isAlreadySelected = state.selectedCategoryId == catIdInt;
    final targetCategoryId = isAlreadySelected ? null : catIdInt;

    emit(
      state.copyWith(
        selectedCategoryId: () => targetCategoryId,
        isAartisLoading: true,
        page: 1,
        hasMore: true,
      ),
    );

    final result = await _aartiService.getAartis(
      categoryId: targetCategoryId,
      page: 1,
      limit: 10,
    );

    if (result.isSuccess && result.data != null) {
      final aartis = _withFavorites(result.data!);
      emit(
        state.copyWith(
          isAartisLoading: false,
          popularAartis: aartis,
          page: 1,
          hasMore: result.data!.length >= 10,
          status: aartis.isEmpty ? HomeStatus.empty : HomeStatus.success,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isAartisLoading: false,
          popularAartis: const [],
          status: HomeStatus.empty,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }

  /// Loads more aartis for infinite scrolling / pagination
  Future<void> loadMoreAartis() async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;
    final result = await _aartiService.getAartis(
      categoryId: state.selectedCategoryId,
      page: nextPage,
      limit: 10,
    );

    if (result.isSuccess && result.data != null) {
      final newItems = _withFavorites(result.data!);
      final updatedList = List<AartiModel>.from(state.popularAartis)..addAll(newItems);
      emit(
        state.copyWith(
          isLoadingMore: false,
          popularAartis: updatedList,
          page: nextPage,
          hasMore: newItems.length >= 10,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  /// Pull-to-refresh
  Future<void> refresh() async {
    if (state.selectedCategoryId != null) {
      final result = await _aartiService.getAartis(
        categoryId: state.selectedCategoryId,
        page: 1,
        limit: 10,
      );
      if (result.isSuccess && result.data != null) {
        emit(
          state.copyWith(
            popularAartis: _withFavorites(result.data!),
            page: 1,
            hasMore: result.data!.length >= 10,
          ),
        );
      }
    } else {
      await loadHomeData();
    }
  }

  void syncFavorites() {
    emit(
      state.copyWith(
        popularAartis: _withFavorites(state.popularAartis),
      ),
    );
  }

  void updateBannerIndex(int index) {
    emit(state.copyWith(currentBannerIndex: index));
  }

  Future<void> toggleFavorite(String aartiId) async {
    await _sharedPref.toggleFavoriteAarti(aartiId);
    emit(
      state.copyWith(
        popularAartis: _withFavorites(state.popularAartis),
      ),
    );
  }

  List<AartiModel> get favoriteAartis =>
      state.popularAartis.where((aarti) => aarti.isFavorite).toList();

  List<AartiModel> _withFavorites(List<AartiModel> aartis) {
    final favoriteIds = _sharedPref.favoriteAartiIds;
    return aartis
        .map((aarti) => aarti.copyWith(isFavorite: favoriteIds.contains(aarti.id)))
        .toList();
  }
}

