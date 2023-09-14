part of 'book_library_get_bloc.dart';

@immutable
abstract class BookLibraryGetEvent {
  const BookLibraryGetEvent();
}

final class GetAllBookEvent extends BookLibraryGetEvent {
  const GetAllBookEvent();
}

final class GetInReadingBookEvent extends BookLibraryGetEvent {
  const GetInReadingBookEvent();
}

final class GetWillBeReadBookEvent extends BookLibraryGetEvent {
  const GetWillBeReadBookEvent();
}

final class GetHasBeenReadBookEvent extends BookLibraryGetEvent {
  const GetHasBeenReadBookEvent();
}

final class GetLikesBookEvent extends BookLibraryGetEvent {
  const GetLikesBookEvent();
}
