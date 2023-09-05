import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'filter_mark_state.dart';

class FilterMarkCubit extends Cubit<FilterMarkState> {
  FilterMarkCubit() : super(FilterMarkState.title(FilterMark.title));

  void setFilterToTitle() {
    emit(FilterMarkState.title(FilterMark.title));
  }

  void setFilterToAuthor() {
    emit(FilterMarkState.author(FilterMark.author));
  }
}
