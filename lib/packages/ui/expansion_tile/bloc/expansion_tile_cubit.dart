import 'package:flutter_bloc/flutter_bloc.dart';

class ExpansionTileCubit extends Cubit<bool> {
  ExpansionTileCubit() : super(false);

  void setExpanded(bool value) => emit(value);
}
