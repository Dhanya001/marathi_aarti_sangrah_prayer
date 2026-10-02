import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/service/home_service.dart';

class AartiService {
  AartiService({HomeService? homeService, SharedPref? sharedPref})
      : _homeService = homeService ?? HomeService(),
        _sharedPref = sharedPref ?? locator<SharedPref>();

  final HomeService _homeService;
  final SharedPref _sharedPref;

  List<AartiModel> getAartis() {
    final favoriteIds = _sharedPref.favoriteAartiIds;
    return _homeService.getPopularAartis().map((aarti) {
      return aarti.copyWith(isFavorite: favoriteIds.contains(aarti.id));
    }).toList();
  }

  Future<bool> toggleFavorite(String aartiId) {
    return _sharedPref.toggleFavoriteAarti(aartiId);
  }
}
