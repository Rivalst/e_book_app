part of 'book_text_detail_cubit.dart';

@immutable
abstract class BookTextDetailState {
  abstract final String countOfWords;
  abstract final String timeForRead;
}

class BookTextDetailInitial extends BookTextDetailState {
  BookTextDetailInitial({
    required this.countOfWords,
    required this.timeForRead,
  });

  @override
  final String countOfWords;

  @override
  final String timeForRead;

}
