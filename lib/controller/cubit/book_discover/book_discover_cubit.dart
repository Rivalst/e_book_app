import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:meta/meta.dart';

part 'book_discover_state.dart';

class BookDiscoverCubit extends Cubit<List<Book>> {
  BookDiscoverCubit({required this.books}) : super([]);

  final List<Book> books;

  void bookSearchByTitle(String element) {
    final trimmedElement = element.trim();

    if (trimmedElement.isEmpty) {
      emit([]);
    } else {
      emit(books.where((book) => book.title.contains(element)).toList());
    }
  }

  void bookSearchByAuthor(String element) {
    final trimmedElement = element.trim();
    if (trimmedElement.isEmpty) {
      emit([]);
    } else {
      emit(books.where((book) => book.authorName.contains(element)).toList());
    }
  }
}
