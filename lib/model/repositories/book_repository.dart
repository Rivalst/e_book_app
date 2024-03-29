import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Map<String, dynamic> booksInLibraryMap = {};

  static final BooksRepository _instance =
      BooksRepository._privateConstructor();

  BooksRepository._privateConstructor();

  static BooksRepository get instance => _instance;

  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firabaseAuth = FirebaseAuth.instance;

  Future<void> fetchBooksData() async {
    try {
      final mapOfBooks = await _firebaseFirestore.collection('booksData').get();
      for (var doc in mapOfBooks.docs) {
        final bookData = doc.data();
        final book = Book.fromJson(bookData);
        bool containsBook =
            books.any((existingBook) => existingBook.id == book.id);
        if (!containsBook) {
          books.add(book);
        }
      }
    } on FirebaseException catch (e) {
      throw BooksDataGetFailure.fromCode(e.code, e.message);
    } catch (_) {
      throw const BooksDataGetFailure();
    }
  }

  Future<void> fetchBookLibraryData() async {
    try {
      final user = _firabaseAuth.currentUser;
      final userUID = user?.uid;
      if (userUID != null) {
        final dataUser =
            await _firebaseFirestore.collection('users').doc(userUID).get();
        booksInLibraryMap = dataUser.data()!['booksData'];
      } else {
        booksInLibraryMap = {};
      }
    } on FirebaseException catch (e) {
      throw BooksDataGetFailure.fromCode(e.code, e.message);
    } catch (_) {
      throw const BooksDataGetFailure();
    }
  }
}
