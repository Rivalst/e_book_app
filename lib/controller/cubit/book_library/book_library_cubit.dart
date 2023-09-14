import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/books_library_set_or_remove.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';

class BookLibraryCubit extends Cubit<bool> {
  final BookLibraryAddOrDelete _bookLibraryAddOrDelete;

  final BooksRepository _booksRepository;

  final int _id;

  BookLibraryCubit(
      {required int id,
      required BookLibraryAddOrDelete bookLibraryAddOrDelete,
      required BooksRepository booksRepository}
      ): _id = id,
        _booksRepository = booksRepository,
        _bookLibraryAddOrDelete = bookLibraryAddOrDelete,
        super(booksRepository.booksInLibraryMap![id.toString()] != null
            ? true
            : false);

  void bookAddInCollection() {
    _bookLibraryAddOrDelete.bookAddInLibrary(_id);
    _booksRepository.booksInLibraryMap![_id.toString()] = {'status': ''};
    emit(true);
  }

  void bookRemoveInLibrary() {
    _bookLibraryAddOrDelete.bookRemoveInLibrary(_id);
    _booksRepository.booksInLibraryMap!.remove(_id.toString());
    emit(false);
  }
}
