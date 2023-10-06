import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

part 'book_text_detail_state.dart';

class BookTextDetailCubit extends Cubit<BookTextDetailState> {
  BookTextDetailCubit({required String link})
      : _link = link,
        super(BookTextDetailInitial(countOfWords: '-', timeForRead: '-')) {
    getCountOfWords(link);
  }

  String _link;

  Future<void> getCountOfWords(String link) async {
    final response = await http
        .get(Uri.parse(_link));
    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final text = document.body!.text;
      countWords(text);
    } else {}
  }


  void countWords(String text) {
    final words = text.split(RegExp(r'\s+'));
    words.removeWhere((word) => word.isEmpty);
    final time = ((words.length / 150) / 60).toStringAsFixed(1);
    emit(BookTextDetailInitial(countOfWords: words.length.toString(), timeForRead: '$time h'));
  }
}
