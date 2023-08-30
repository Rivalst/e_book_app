import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:equatable/equatable.dart';

part 'book_get_event.dart';

part 'book_get_state.dart';

class BookGetBloc extends Bloc<BookGetEvent, BookGetState> {
  final List<Book> bookDataLoad;

  BookGetBloc(this.bookDataLoad)
      : super(bookDataLoad.isEmpty
            ? BookGetState.loading(bookDataLoad)
            : BookGetState.loaded(bookDataLoad)
  );
}
