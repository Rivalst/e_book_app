import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class BookDataLoad {
  Future<Map<String, dynamic>?> mapOfBooksData();
}

class BookDataGet extends BookDataLoad {
  @override
  Future<Map<String, dynamic>?> mapOfBooksData() async {
    final response = await http.get(Uri.parse('http://gutendex.com/books/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  }
}