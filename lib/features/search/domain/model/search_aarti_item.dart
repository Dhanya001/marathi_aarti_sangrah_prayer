import 'package:equatable/equatable.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';

class SearchAartiItem extends Equatable {
  const SearchAartiItem({
    required this.aarti,
    required this.duration,
  });

  final AartiModel aarti;
  final String duration;

  @override
  List<Object?> get props => [aarti, duration];
}
