import 'package:bloc/bloc.dart';



class IsLoadCubit extends Cubit<bool> {
  IsLoadCubit() : super(false);

  void loaded(){
    emit(true);
  }
}
