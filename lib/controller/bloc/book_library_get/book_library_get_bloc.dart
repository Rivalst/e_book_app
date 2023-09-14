import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_library_get_event.dart';

part 'book_library_get_state.dart';

class BookLibraryGetBloc
    extends Bloc<BookLibraryGetEvent, BookLibraryGetState> {
  List<Book> booksList;
  Map<String, dynamic>? booksMap;

  BookLibraryGetBloc({required this.booksList, required this.booksMap})
      : super(BookLibraryGetState.allLibrary(
            booksList: booksList
                .where((book) => booksMap![book.id.toString()] != null)
                .toList()));
}
