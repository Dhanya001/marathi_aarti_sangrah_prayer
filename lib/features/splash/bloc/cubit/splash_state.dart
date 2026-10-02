import 'package:equatable/equatable.dart';

enum SplashStatus { initial, loading, completed }

class SplashState extends Equatable {
  const SplashState({
    this.status = SplashStatus.initial,
  });

  final SplashStatus status;

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
