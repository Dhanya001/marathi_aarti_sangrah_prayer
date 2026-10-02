import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/features/home/bloc/cubit/home_state.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeService? homeService, SharedPref? sharedPref})
      : _homeService = homeService ?? HomeService(),
        _sharedPref = sharedPref ?? locator<SharedPref>(),
        super(const HomeState(isLoading: true)) {
    loadHomeData();
  }

  final HomeService _homeService;
  final SharedPref _sharedPref;

  void loadHomeData() {
    emit(
      state.copyWith(
        isLoading: false,
        banners: _homeService.getBanners(),
        categories: _homeService.getCategories(),
        popularAartis: _withFavorites(_homeService.getPopularAartis()),
      ),
    );
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
