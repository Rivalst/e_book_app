part of 'book_get_bloc.dart';

// bookDataLoad.mapOfBooksDataLoad()

enum LoadedBooksStatus { loading, loaded }

final class BookGetState extends Equatable {
  const BookGetState._(
      {required LoadedBooksStatus status, List<Book>? dataBookLoad})
      : _dataBookLoad = dataBookLoad,
        _status = status;

  factory BookGetState.loading(List<Book> data) {
    return const BookGetState._(status: LoadedBooksStatus.loading);
  }

  factory BookGetState.loaded(List<Book> data) {
    return BookGetState._(status: LoadedBooksStatus.loaded, dataBookLoad: data);
  }

  final List<Book>? _dataBookLoad;
  final LoadedBooksStatus _status;

  List<Book>? get dataBookLoad => _dataBookLoad;

  LoadedBooksStatus get status => _status;

  List<Book>? randomListOfBooks() {
    final Random random = Random();
    final List<Book>? randomBook =
        _dataBookLoad != null ? List.from(_dataBookLoad!) : null;
    if (randomBook != null) randomBook.shuffle(random);
    return randomBook;
  }

  List<Book>? newestListOfBooks() {
    final Random random = Random();

    if (_dataBookLoad == null) {
      return null;
    }

    final List<Book> filteredBooks =
        _dataBookLoad!.where((book) => book.authorBirthday > 1800).toList();
    filteredBooks.shuffle(random);

    return filteredBooks.isNotEmpty ? filteredBooks : null;
  }

  @override
  List<Object?> get props => [dataBookLoad];
}
