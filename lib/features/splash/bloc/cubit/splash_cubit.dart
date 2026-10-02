import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/splash/bloc/cubit/splash_state.dart';
import 'package:infocontract/features/splash/domain/service/splash_service.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({SplashService? splashService})
      : _splashService = splashService ?? SplashService(),
        super(const SplashState());

  final SplashService _splashService;

  Future<void> initialize() async {
    if (state.status == SplashStatus.loading) return;

    emit(state.copyWith(status: SplashStatus.loading));
    await _splashService.initializeApp();
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
