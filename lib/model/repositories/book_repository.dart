import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';

class BooksDataGetFailure implements Exception {
  const BooksDataGetFailure(
      [this.code = 'An unknown error code',
      this.message = 'An unknown error code']);

  final String code;
  final String? message;

  factory BooksDataGetFailure.fromCode(String code, String? message) {
    return BooksDataGetFailure(code, message);
  }
}

class BooksRepository {
  List<Book> books = [];

  static final BooksRepository _instance =
      BooksRepository._privateConstructor();

  BooksRepository._privateConstructor();

  static BooksRepository get instance => _instance;

  final _firebase = FirebaseFirestore.instance;

  Future<void> fetchBooksData() async {
    try {
      final mapOfBooks = await _firebase.collection('books').get();
      for (var doc in mapOfBooks.docs) {
        final bookData = doc.data();
        final book = Book.fromJson(bookData);
        books.add(book);
      }
    } on FirebaseException catch (e) {
      throw BooksDataGetFailure.fromCode(e.code, e.message);
    } catch (_) {
      throw const BooksDataGetFailure();
    }
  }
}
