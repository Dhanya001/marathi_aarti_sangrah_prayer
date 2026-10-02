import 'package:equatable/equatable.dart';

abstract class ListBaseModel extends Equatable {
  ListBaseModel fromJsonListBase(Map<String, dynamic> json);
}
