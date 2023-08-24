import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/remote/book_data.dart';
import 'package:e_book_app/model/dataresources/remote/book_model.dart';
import 'package:equatable/equatable.dart';

part 'book_get_event.dart';

part 'book_get_state.dart';

class BookGetBloc extends Bloc<BookGetEvent, BookGetState> {
  final BooksRepository bookDataLoad;

  BookGetBloc(this.bookDataLoad)
      : super(bookDataLoad.books.isEmpty
            ? BookGetState.loading(bookDataLoad)
            : BookGetState.loaded(bookDataLoad)
  );
}
