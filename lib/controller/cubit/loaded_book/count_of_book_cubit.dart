import 'package:bloc/bloc.dart';


class CountOfBookCubit extends Cubit<int> {
  CountOfBookCubit() : super(10);
  
  void load(){
    emit(state + 10);
  }
}
