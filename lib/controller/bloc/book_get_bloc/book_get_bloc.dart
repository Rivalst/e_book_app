import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/remote/book_data.dart';
import 'package:meta/meta.dart';

part 'book_get_event.dart';

part 'book_get_state.dart';

class BookGetBloc extends Bloc<String, Map<String, dynamic>?> {
  final BookDataLoad bookDataLoad;

  BookGetBloc(this.bookDataLoad) : super(null);

  Future<Map<String, dynamic>?> mapEventToState(String event) async {
    return await bookDataLoad.mapOfBooksData();
  }
}
