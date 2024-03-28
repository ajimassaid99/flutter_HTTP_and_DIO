part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();
  
  @override
  List<Object> get props => [];
}

class ItemsInitial extends ItemsState {}
class ItemsSuccess extends ItemsState {
  final List<Item> data;
 const ItemsSuccess({required this.data});
 @override
  List<Object> get props => [data];
}
class ItemsLoading extends ItemsState {}
class ItemsFailed extends ItemsState {}
