import 'package:equatable/equatable.dart';

abstract class ListBaseModel extends Equatable {
  const ListBaseModel();
  ListBaseModel fromJsonListBase(Map<String, dynamic> json);
}
