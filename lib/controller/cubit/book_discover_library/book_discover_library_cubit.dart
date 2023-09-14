import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';

class BookDiscoverLibraryCubit extends Cubit<List<Book>> {
  BookDiscoverLibraryCubit() : super([]);

  void search(String element) {
    List<Book> books = BooksRepository.instance.books
        .where((book) =>
            BooksRepository.instance.booksInLibraryMap![book.id.toString()] !=
            null)
        .toList();
    emit(books
        .where((book) =>
            book.title.contains(element) || book.authorName.contains(element))
        .toList());
  }
}
