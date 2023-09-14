part of 'book_library_get_bloc.dart';

enum LibraryMark { allLibrary, inReading, willBeRead, hasBeenRead, likes }

@immutable
final class BookLibraryGetState extends Equatable {
  final List<Book> _books;
  final LibraryMark _status;

  const BookLibraryGetState._(
      {required List<Book> books, required LibraryMark status})
      : _books = books,
        _status = status;

  factory BookLibraryGetState.allLibrary(
      {required List<Book> booksList, LibraryMark? statusMark}) {
    return BookLibraryGetState._(
        books: booksList, status: statusMark ?? LibraryMark.allLibrary);
  }

  factory BookLibraryGetState.inReading(
      {required List<Book> booksList, LibraryMark? statusMark}) {
    return BookLibraryGetState._(
        books: booksList, status: statusMark ?? LibraryMark.inReading);
  }

  factory BookLibraryGetState.willBeRead(
      {required List<Book> booksList, LibraryMark? statusMark}) {
    return BookLibraryGetState._(
        books: booksList, status: statusMark ?? LibraryMark.willBeRead);
  }

  factory BookLibraryGetState.hasBeenRead(
      {required List<Book> booksList, LibraryMark? statusMark}) {
    return BookLibraryGetState._(
        books: booksList, status: statusMark ?? LibraryMark.hasBeenRead);
  }

  factory BookLibraryGetState.likes(
      {required List<Book> booksList, LibraryMark? statusMark}) {
    return BookLibraryGetState._(
        books: booksList, status: statusMark ?? LibraryMark.likes);
  }

  List<Book> get books => _books;

  LibraryMark get status => _status;

  @override
  List<Object?> get props => [_books, _status];
}
