import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/core/api/api_dio_client.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/packages/ui/dropdowns/network_dropdown/dropdown_menu_item_model.dart';

part 'network_dropdown_state.dart';

class SmartDropdownCubit extends Cubit<NetworkDropdownState> {
  final String endpoint;
  final String labelKey;
  final String idKey;
  final Map<String, dynamic>? queryParam;

  SmartDropdownCubit({
    required this.endpoint,
    required this.labelKey,
    required this.idKey,
    this.queryParam,
  }) : super(DropdownInitial());

  final ApiDioClient _dio = locator<ApiDioClient>();

  void loadItems() async {
    emit(DropdownLoading());
    try {
      final response = await _dio.fetchOptions(
        endpoint,
        queryParameters: queryParam,
      );

      if (response.data != null) {
        final data = response.data;

        // If response is a list
        final List decoded = data ?? [];

        final items = decoded.map<DropdownMenuItemModel>((e) {
          return DropdownMenuItemModel.fromJson(e);
        }).toList();

        emit(DropdownLoaded(items));
      } else {
        emit(DropdownError('Failed to fetch data'));
      }
    } catch (e) {
      emit(DropdownError('Error: ${e.toString()}'));
    }
  }
}
