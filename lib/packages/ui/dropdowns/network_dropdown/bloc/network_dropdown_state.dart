part of 'network_dropdown_bloc.dart';

abstract class NetworkDropdownState {}

class DropdownInitial extends NetworkDropdownState {}

class DropdownLoading extends NetworkDropdownState {}

class DropdownLoaded extends NetworkDropdownState {
  final List<DropdownMenuItemModel> items;
  DropdownLoaded(this.items);
}

class DropdownError extends NetworkDropdownState {
  final String message;
  DropdownError(this.message);
}
