import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, int> {
  BottomBarBloc() : super(0) {
    on<BottomBarSetIndex>(_setIndex);
  }

  void _setIndex(BottomBarSetIndex event, Emitter<int> emit){
    return emit(event.index);
  }
}
