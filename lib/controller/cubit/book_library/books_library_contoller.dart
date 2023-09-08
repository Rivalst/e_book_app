import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class BookLibraryController {
  abstract final FirebaseFirestore _firebaseFirestore;
  abstract final firebase_auth.FirebaseAuth _firebaseAuth;

  const BookLibraryController();

  void bookAddInLibrary(int id);

  void bookRemoveInLibrary(int id);
}

class BookLibraryAddOrDelete extends BookLibraryController {
  @override
  final FirebaseFirestore _firebaseFirestore;

  @override
  final firebase_auth.FirebaseAuth _firebaseAuth;

  BookLibraryAddOrDelete(
      {FirebaseFirestore? firebaseFirestore,
      firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  void bookAddInLibrary(int id) async {
    try {
      final user = _firebaseAuth.currentUser;
      final userUID = user?.uid;

      final userDoc =
          await _firebaseFirestore.collection('users').doc(userUID).get();

      final books = userDoc.data()?['books'] ?? <String, dynamic>{};

      books[id.toString()] = {'status': ''};

      await _firebaseFirestore
          .collection('users')
          .doc(userUID)
          .update({'books': books});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void bookRemoveInLibrary(int id) async {
    try {
      final user = _firebaseAuth.currentUser;
      final userUID = user?.uid;

      final dataUser =
          await _firebaseFirestore.collection('users').doc(userUID).get();

      final Map<String, dynamic> books =
          Map<String, dynamic>.from(dataUser['books']);

      books.remove(id.toString());

      await _firebaseFirestore.collection('users').doc(userUID).update({
        'books': books,
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
