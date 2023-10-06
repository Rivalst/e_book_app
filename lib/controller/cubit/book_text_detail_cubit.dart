import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_text_detail_state.dart';

class BookTextDetailCubit extends Cubit<BookTextDetailState> {
  BookTextDetailCubit() : super(BookTextDetailInitial());
}
