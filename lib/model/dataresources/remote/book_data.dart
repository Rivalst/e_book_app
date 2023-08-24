import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book_app/model/dataresources/remote/book_model.dart';

class BooksRepository {
  final String baseUrl = 'http://gutendex.com/books/';
  List<Book> books = [];

  static final BooksRepository _instance = BooksRepository._privateConstructor();

  BooksRepository._privateConstructor();

  static BooksRepository get instance => _instance;

  final _firebase = FirebaseFirestore.instance;

  // Future<void> fetchBooks(String url) async {
  //   print('url: $url');
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final List<dynamic> results = jsonData['results'];
  //
  //     if (results.isNotEmpty) {
  //       for (var result in results) {
  //         final book = Book.fromJson(result);
  //         await _firebase.collection('books').add({
  //           'id': result['id'],
  //           'title': result['title'],
  //           'authors': result['authors'],
  //           'subjects': result['subjects'],
  //           'languages': result['languages'],
  //           'image': result['formats']['image/jpeg'],
  //           'text': result['formats']['text/plain'],
  //         });
  //         books.add(book);
  //       }
  //     }
  //     // final String? nextUrl = jsonData['next'];
  //     // if (nextUrl != null) {
  //     //   await fetchBooks(nextUrl);
  //     // }
  //   } else {
  //     throw Exception('Failed to fetch books');
  //   }
  //
  // }
  Future<void> fetchBooksData() async {
    final mapOfBooks = await _firebase.collection('books').get();
    for (var doc in mapOfBooks.docs) {
      final bookData = doc.data();
      final book = Book.fromJson(bookData);
      books.add(book);
    }
  }

  // Future<void> fetchMultiplePages() async {
  //   final List<Future<void>> fetchFutures = [];
  //
  //   for (int page = 2; page <= 50; page++) {
  //     final url = 'http://gutendex.com/books/?page=$page';
  //     await fetchBooks(url); // Assuming fetchBooks is your existing function
  //   }
  // }
}
