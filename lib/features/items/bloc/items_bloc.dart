import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapi/features/items/model/items.dart';
import 'package:restapi/features/items/services/items_services.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<GetItems>((event, emit) async{
     try{
      emit(ItemsLoading());
      await Future.delayed(const Duration(seconds: 2));
      final List<Item> items = await fetchItems();
      emit(ItemsSuccess(data: items));
     }catch(e){
      print(e);
      emit(ItemsFailed());
     }
    });
  }
}
