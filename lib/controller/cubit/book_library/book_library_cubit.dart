import 'package:bloc/bloc.dart';
import 'package:e_book_app/controller/cubit/book_library/books_library_contoller.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';

class BookLibraryCubit extends Cubit<bool> {
  final BookLibraryAddOrDelete _bookLibraryAddOrDelete;

  final BooksRepository _booksRepository;

  final int _id;

  BookLibraryCubit(
      {required int id,
      required BookLibraryAddOrDelete bookLibraryAddOrDelete,
      required BooksRepository booksRepository})
      : _id = id,
        _booksRepository = booksRepository,
        _bookLibraryAddOrDelete = bookLibraryAddOrDelete,
        super(booksRepository.booksInLibrary!['books'][id.toString()] != null
            ? true
            : false);

  void bookAddInCollection() {
    _bookLibraryAddOrDelete.bookAddInLibrary(_id);
    _booksRepository.booksInLibrary!['books'][_id.toString()] = {'status': ''};
    emit(true);
  }

  void bookRemoveInLibrary() {
    _bookLibraryAddOrDelete.bookRemoveInLibrary(_id);
    emit(false);
  }
}
